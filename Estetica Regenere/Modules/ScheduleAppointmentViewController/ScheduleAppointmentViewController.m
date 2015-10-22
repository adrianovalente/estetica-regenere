//
//  ScheduleAppointmentViewController.m
//  Estetica Regenere
//
//  Created by Adriano on 10/16/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "ScheduleAppointmentViewController.h"
#import "JASidePanelController.h"
#import "MenuViewController.h"
#import "BaseHeaderView.h"
#import "LoadingView.h"
#import "RegenerePickerView.h"
#import "AreasProvider.h"
#import "ServicesProvider.h"
#import "BasicButtonView.h"

@interface ScheduleAppointmentViewController () <BaseHeaderViewDelegate, AreasProviderCallback, ServicesProviderCallback, UIAlertViewDelegate, RegenerePickerViewDelegate>
@property (weak, nonatomic) IBOutlet BaseHeaderView *header;
@property (weak, nonatomic) IBOutlet LoadingView *loadingView;
@property (weak, nonatomic) IBOutlet RegenerePickerView *areaPickerView;
@property (weak, nonatomic) IBOutlet RegenerePickerView *servicePickerView;
@property (weak, nonatomic) IBOutlet RegenerePickerView *datePickerView;
@property (weak, nonatomic) IBOutlet RegenerePickerView *timePickerView;
@property (weak, nonatomic) IBOutlet BasicButtonView *button;

@end

@implementation ScheduleAppointmentViewController

#pragma mark - setup methods
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Select "Marcar consulta" button @ side menu
    JASidePanelController *panelController = (JASidePanelController *)self.navigationController.parentViewController;
    [(MenuViewController *)panelController.leftPanel selectCell:1];
    [self populateAreasPicker];
}

-(void)setup
{
    [self setupNavBar];
    [self setupHeader];
    [self setupPickers];
    [self setupButton];
}

- (void) setupNavBar
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

-(void)setupHeader
{
    [self.header setDelegate:self];
    [self.header updateDescriptionLabel:@"Marque sua consulta agora"];
    [self.header updateWithName:[[NSUserDefaults standardUserDefaults] objectForKey:@"user-name"]];
}

-(void)setupPickers
{
    [self.areaPickerView setPlaceholder:@"Área de atendimento"];
    [self.areaPickerView setDelegate:self];
    [self.servicePickerView setPlaceholder:@"Serviço"];
    [self.areaPickerView setDelegate:self];
    [self.datePickerView setPlaceholder:@"Data"];
    [self.datePickerView setDelegate:self];
}

-(void)setupButton
{
    [self.button setTitle:@"Marcar"];
    [self.button setType:BasicButtonTypeCallToAction];
}

#pragma mark - Private Methods
-(void)populateAreasPicker
{
    [self.loadingView startLoading];
    [[AreasProvider new] getAreasWithCallback:self];
}

-(void) displayAlertWithTitle:(NSString *)title message:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];

}

#pragma mark - Base Header View Delegate
-(void)didTapMenuButton
{
    [(JASidePanelController *)self.navigationController.parentViewController toggleLeftPanel:self];
}

#pragma mark - Areas Provider Callback
- (void)onGetAreasSuccess:(NSArray *)areas
{
    [self.areaPickerView updateWithOptions:areas];
    [self.loadingView stopLoading];
}

#pragma mark - Services Provider Callback
- (void)onGetServicesSuccess:(NSArray *)services
{
    [self.servicePickerView updateWithOptions:services];
    [self.loadingView stopLoading];
}

#pragma mark - Base Provider Callback
-(void)onNetworkFailure
{
    [self displayAlertWithTitle:@"Erro na rede" message:@"Não foi possível se conectar à Internet. Por favor tente mais tarde."];
}

-(void)onResponseFailure
{
    [self displayAlertWithTitle:@"Erro na rede" message:@"Não foi possível se conectar à Internet. Por favor tente mais tarde."];
}

#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Regenere Picker View Delegate
-(void)regenerePickerView:(id)pickerView didChangeToValue:(NSString *)value
{
    if (pickerView == self.areaPickerView) {
        [self.loadingView startLoading];
        [[ServicesProvider new] getServicesWithAreaId:[self.areaPickerView getSelectedOptionValue] callback:self];
        return;
    }
}
@end