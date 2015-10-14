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

@interface HomeViewController () <HomeTableViewManagerDelegate, HomeHeaderViewDelegate, HomeProviderCallback, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet LoadingView *loadingView;
@property (weak, nonatomic) IBOutlet UITableView *consultasTableView;
@property (weak, nonatomic) IBOutlet HomeHeaderView *header;
@property (strong, nonatomic) HomeTableViewManager *homeTableViewManager;
@end

@implementation HomeViewController {
    BOOL _hasToPushToLogin;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [[HomeProvider new] performHomeRequestWithCallback:self];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self unselectAllCells];
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
    [self.homeTableViewManager updateWithData:@[@"", @"", @"", @"", @"", @"", @""]];
}

- (void) setupNavBar
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)pushUnderConstructionVC
{
    [self.navigationController pushViewController:[UnderConstructionViewController new] animated:YES];
}

- (void)unselectAllCells
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
-(void) didSelectConsulta:(NSInteger)consultaId
{
    [self pushUnderConstructionVC];
}

#pragma mark - HomeHeaderViewDelegate
-(void) didSelectMarcarConsulta
{
    [self pushUnderConstructionVC];
}

#pragma mark - HomeProviderCallback
-(void)onTokenMissing
{
    [self displayAlertWithTitle:@"Falha na autenticação" message:@"Ops! Você precisa fazer login denovo."];
    _hasToPushToLogin = YES;
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
    [self.header updateWithName:name appointments:thisWeek];
}

-(void)onHomeRequestFailure
{
    [self displayAlertWithTitle:@"Erro na rede" message:@"Não foi possível caregar os dados. Por favor tente mais tarde."];
}

#pragma mark - UIAlertView Delegate
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.loadingView stopLoading];
    if (_hasToPushToLogin) {
        [self.navigationController presentViewController:[LoginViewController new] animated:YES completion:^{}];
    }
}

#pragma mark - other private methods
-(void) displayAlertWithTitle:(NSString *)title message:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

#pragma mark - Lazy instantiation
-(HomeTableViewManager *) homeTableViewManager
{
    if (!_homeTableViewManager) _homeTableViewManager = [[HomeTableViewManager alloc] initWithTableView:self.consultasTableView];
    return _homeTableViewManager;
}

@end
