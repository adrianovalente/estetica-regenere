//
//  HomeViewController.m
//  Estetica Regenere
//
//  Created by Adriano on 10/11/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeHeaderView.h"
#import "HomeTableViewManager.h"
#import "UnderConstructionViewController.h"
#import "HomeProvider.h"
#import "LoadingView.h"
#import "LoginViewController.h"
#import "AppointmentsList.h"
#import "JASidePanelController.h"
#import "MenuViewController.h"
#import "DeleteAppointmentProvider.h"
#import "ScheduleAppointmentViewController.h"

@interface HomeViewController () <HomeTableViewManagerDelegate, HomeHeaderViewDelegate, HomeProviderCallback, UIAlertViewDelegate, LoginViewControllerCallback, DeleteAppointmentCallback>

@property (weak, nonatomic) IBOutlet LoadingView *loadingView;
@property (weak, nonatomic) IBOutlet UITableView *consultasTableView;
@property (weak, nonatomic) IBOutlet HomeHeaderView *header;
@property (strong, nonatomic) HomeTableViewManager *homeTableViewManager;
@property (nonatomic) UIAlertView *deleteAlertView;
@end

@implementation HomeViewController {
    BOOL _hasToPushToLogin;
    BOOL _isShowingCenterPanel;
    BOOL _noNeedToShowAlerts;
    int _appointmentToDelete;
}

-(instancetype)initFromLogout
{
    self = [super init];
    _noNeedToShowAlerts = YES;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self updateData];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self unselectAllHomeTBVCells];
    [self resetMenuOptions];
}


# pragma mark - Setup methods
- (void)setup
{
    _hasToPushToLogin = NO;
    [self.header setDelegate:self];
    [self setupNavBar];
    [self setupTableView];
}

- (void) setupTableView
{
    [self.homeTableViewManager setDelegate:self];
}

- (void) setupNavBar
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)pushUnderConstructionVC
{
    [self.navigationController pushViewController:[UnderConstructionViewController new] animated:YES];
}

- (void)unselectAllHomeTBVCells
{
    for (int section = 0; section < [self.consultasTableView numberOfSections]; section++) {
        for (int row = 0; row < [self.consultasTableView numberOfRowsInSection:section]; row++) {
            NSIndexPath* cellPath = [NSIndexPath indexPathForRow:row inSection:section];
            UITableViewCell* cell = [self.consultasTableView cellForRowAtIndexPath:cellPath];
            [cell setSelected:NO];
        }
    }
}

#pragma mark - HomeTableViewManagerDelegate
-(void) didSelectConsulta:(int)consultaId
{
    _appointmentToDelete = consultaId;
    [self.deleteAlertView show];
}

#pragma mark - HomeHeaderViewDelegate
-(void) didSelectMarcarConsulta
{
    // Pushando só pra dar ideia de continuidade par ao usuário.
    // Na verdade não tem como dar pop nesta VC
    [self.navigationController pushViewController:[ScheduleAppointmentViewController new] animated:YES];
}

-(void) didSelectMais
{
    _isShowingCenterPanel = !_isShowingCenterPanel;
    if (_isShowingCenterPanel) {
        [(JASidePanelController *) self.navigationController.parentViewController toggleLeftPanel:self];
    } else {
        [(JASidePanelController *)self.navigationController.parentViewController showCenterPanelAnimated:YES];
    }
}

#pragma mark - HomeProviderCallback
-(void)onTokenMissing
{
    _hasToPushToLogin = YES;
    [self displayAlertWithTitle:@"Falha na autenticação" message:@"Ops! Você precisa fazer login de novo."];
}

-(void)onNetworkFailure
{
    [self displayAlertWithTitle:@"Erro na rede" message:@"Não possível se conectar à Internet"];
}

-(void)onResponseFailure
{
    [self displayAlertWithTitle:@"Erro na rede" message:@"Não foi possível caregar os dados. Por favor tente mais tarde."];
}


-(void)onHomeRequestSuccessWithName:(NSString *)name
                       appointments:(NSArray *)appointments
                           thisWeek:(NSNumber *)thisWeek
{
    [self.header updateWithName:name appointments:[NSNumber numberWithInteger:[appointments count]]];
    [self.homeTableViewManager updateWithData:appointments];
    [self.loadingView stopLoading];
}

-(void)onHomeRequestFailure
{
    [self displayAlertWithTitle:@"Erro na rede" message:@"Não foi possível caregar os dados. Por favor tente mais tarde."];
}

#pragma mark - Login VC Callback
-(void)dismissLoginViewController
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    [self updateData];
    
}

#pragma mark - Delete Appointment Callback
-(void)onDeleteAppointmentFailure
{
    [self displayAlertWithTitle:@"Erro na rede" message:@"Não foi possível deletar a consulta. Por favor tente mais tarde."];
}

-(void)onDeleteAppointmentSuccess
{
    [self updateData];
}

#pragma mark - UIAlertView Delegate
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == self.deleteAlertView) {
        if (buttonIndex == 1) {
            [[DeleteAppointmentProvider new] deleteAppointmentWithId:_appointmentToDelete callback:self];
        }
        return;
    }
    
    [self.loadingView stopLoading];
    if (_hasToPushToLogin) {
        [self.navigationController presentViewController:[[LoginViewController alloc] initWithDelegate:self] animated:YES completion:^{}];
    }
}

#pragma mark - other private methods
-(void) displayAlertWithTitle:(NSString *)title message:(NSString *)message
{
    if (!_noNeedToShowAlerts) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    [self alertView:nil clickedButtonAtIndex:0];
}

-(void)updateData
{
    [[HomeProvider new] performHomeRequestWithCallback:self];
    [self.loadingView startLoading];
}

-(void)resetMenuOptions
{
    JASidePanelController *panel = (JASidePanelController *)self.navigationController.parentViewController;
    [(MenuViewController *)panel.leftPanel resetMenu];
}

#pragma mark - Lazy instantiation
-(HomeTableViewManager *) homeTableViewManager
{
    if (!_homeTableViewManager) _homeTableViewManager = [[HomeTableViewManager alloc] initWithTableView:self.consultasTableView];
    return _homeTableViewManager;
}

-(UIAlertView *)deleteAlertView
{
    if (!_deleteAlertView) _deleteAlertView = [[UIAlertView alloc] initWithTitle:@"Confirmar exclusão" message:@"Tem certeza que deseja desmarcar essa consulta?" delegate:self cancelButtonTitle:@"Não" otherButtonTitles:@"Sim, desmarque", nil];
    return _deleteAlertView;
}

@end
