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
#import "AvailableTimesProvider.h"
#import "BasicButtonView.h"
#import "ScheduleAppointmentProvider.h"

typedef enum ScheduleAppointmentFarthestPickerEnabled : int {
    AreaPicker,
    ServicePicker,
    DatePicker,
    TimePicker
} ScheduleAppointmentFarthestPickerEnabled;

@interface ScheduleAppointmentViewController () <BaseHeaderViewDelegate, AreasProviderCallback, ServicesProviderCallback, AvailableTimesProviderCallback, ScheduleAppointmentProviderCallback, UIAlertViewDelegate, RegenerePickerViewDelegate, BasicButtonProtocol>

@property (weak, nonatomic) IBOutlet BaseHeaderView *header;
@property (weak, nonatomic) IBOutlet LoadingView *loadingView;
@property (weak, nonatomic) IBOutlet RegenerePickerView *areaPickerView;
@property (weak, nonatomic) IBOutlet RegenerePickerView *servicePickerView;
@property (weak, nonatomic) IBOutlet RegenerePickerView *datePickerView;
@property (weak, nonatomic) IBOutlet RegenerePickerView *timePickerView;
@property (weak, nonatomic) IBOutlet BasicButtonView *button;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UILabel *serviceLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@property (nonatomic) ScheduleAppointmentFarthestPickerEnabled farthestEnabled;


// It has to be a property because we're intersted in holding this pointer 4ever o.O
@property (strong, nonatomic) AvailableTimesProvider *timesProvider;

@end

@implementation ScheduleAppointmentViewController {
    BOOL _allowedToDispatchFinalRequest;
    BOOL _noNeedToPopViewControllerAfterDismissingAlertView;
}

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
    [self setFarthestEnabled:AreaPicker];
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
    [self.servicePickerView setDelegate:self];
    [self.datePickerView setPlaceholder:@"Data"];
    [self.datePickerView setDelegate:self];
    [self.timePickerView setPlaceholder:@"Horário"];
    [self.timePickerView setDelegate:self];
}

-(void)setupButton
{
    [self.button setTitle:@"Marcar"];
    [self.button setDelegate:self];
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

-(void)setFarthestEnabled:(ScheduleAppointmentFarthestPickerEnabled)farthestEnabled
{
    if (farthestEnabled == AreaPicker) {
        
        [self.areaLabel setText:@"Primeiro escolha a área"];
        [self.areaLabel setTextColor:[self greenColor]];
        [self.serviceLabel setHidden:YES];
        [self.dateLabel setHidden:YES];
        [self.timeLabel setHidden:YES];
        [self.areaPickerView setStatus:RegenerePickerViewStatusNormal];
        [self.areaPickerView showPlaceHoderInsteadOfSelectedValue:YES];
        [self.servicePickerView setStatus:regenerePickerViewStatusDisabled];
        [self.servicePickerView showPlaceHoderInsteadOfSelectedValue:YES];
        [self.datePickerView setStatus:regenerePickerViewStatusDisabled];
        [self.datePickerView showPlaceHoderInsteadOfSelectedValue:YES];
        [self.timePickerView setStatus:regenerePickerViewStatusDisabled];
        [self.timePickerView showPlaceHoderInsteadOfSelectedValue:YES];

    }
    
    if(farthestEnabled == ServicePicker) {
        [self setFarthestEnabled:AreaPicker];
        [self.areaLabel setText:@"Área"];
        [self.areaLabel setTextColor:[self defaultColor]];
        [self.serviceLabel setHidden:NO];
        [self.serviceLabel setText:@"Agora escolha o serviço"];
        [self.serviceLabel setTextColor:[self greenColor]];
        [self.servicePickerView setStatus:RegenerePickerViewStatusNormal];
        [self.areaPickerView showPlaceHoderInsteadOfSelectedValue:NO];
    }
    
    if (farthestEnabled == DatePicker) {
        [self setFarthestEnabled:ServicePicker];
        [self.serviceLabel setText:@"Servico"];
        [self.serviceLabel setTextColor:[self defaultColor]];
        [self.dateLabel setHidden:NO];
        [self.dateLabel setText:@"Agora escolha a data"];
        [self.dateLabel setTextColor:[self greenColor]];
        [self.datePickerView setStatus:RegenerePickerViewStatusNormal];
        [self.servicePickerView showPlaceHoderInsteadOfSelectedValue:NO];
    }
    
    if (farthestEnabled == TimePicker) {
        [self setFarthestEnabled:DatePicker];
        [self.dateLabel setText:@"Data"];
        [self.dateLabel setTextColor:[self defaultColor]];
        [self.timeLabel setHidden:NO];
        [self.timeLabel setText:@"Agora escolha o horário"];
        [self.timeLabel setTextColor:[self greenColor]];
        [self.timePickerView setStatus:RegenerePickerViewStatusNormal];
        [self.datePickerView showPlaceHoderInsteadOfSelectedValue:NO];
    }
        
    _farthestEnabled = farthestEnabled;
}

-(UIColor *)greenColor
{
    return [UIColor colorWithRed:61/255.0f green:145/255.0f blue:107/255.0f alpha:1.0];
}

-(UIColor *)defaultColor
{
    return [UIColor blackColor];
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

#pragma mark - Times Provider Callback
-(void)onGetAvailableTimesSuccess
{
    [self.datePickerView updateWithOptions:[self.timesProvider getDates]];
    [self.loadingView stopLoading];
}

-(void)onTokenMissing
{
    [self displayAlertWithTitle:@"Falha na autenticação" message:@"Ops! Parece que você tem que fazer login de novo"];
}

#pragma mark - Schedule Provider Callback
- (void)onScheduleAppointmentSuccess
{
    [self displayAlertWithTitle:@"Sucesso" message:@"Consulta agendada com sucesso!"];
}

- (void)onTimeNotAvailable
{
    [self displayAlertWithTitle:@"Horário não disponível" message:@"Ops! Parece que enquanto você pensava alguém marcou na sua frente."];
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
    if (!_noNeedToPopViewControllerAfterDismissingAlertView)
        [self.navigationController popViewControllerAnimated:YES];
    _noNeedToPopViewControllerAfterDismissingAlertView = NO;
}

#pragma mark - Regenere Picker View Delegate
-(void)regenerePickerView:(id)pickerView didChangeToValue:(NSString *)value
{
    _allowedToDispatchFinalRequest = NO;

    if (pickerView == self.areaPickerView) {
        [self.loadingView startLoading];
        [[ServicesProvider new] getServicesWithAreaId:[self.areaPickerView getSelectedOptionValue] callback:self];
        [self setFarthestEnabled:ServicePicker];
        return;
    }
    
    if (pickerView == self.servicePickerView) {
        [self.loadingView startLoading];
        [self.timesProvider getAbailableTimesToService:[self.servicePickerView getSelectedOptionValue] callback:self];
        [self setFarthestEnabled:DatePicker];
    }
    
    if (pickerView == self.datePickerView) {
        [self.timePickerView updateWithOptions:[self.timesProvider getTimesToDate:[self.datePickerView getSelectedOptionValue]]];
        [self setFarthestEnabled:TimePicker];
    }
    
    if (pickerView == self.timePickerView) {
        [self.timeLabel setText:@"Horário"];
        [self.timeLabel setTextColor:[self defaultColor]];
        [self.timePickerView showPlaceHoderInsteadOfSelectedValue:NO];
        _allowedToDispatchFinalRequest = YES;
    }
}
#pragma mark - Basic Button Delegate
-(void)buttonTapped:(id)button
{
    if (!_allowedToDispatchFinalRequest) {
        _noNeedToPopViewControllerAfterDismissingAlertView = YES;
        [self displayAlertWithTitle:@"Espere um pouco!" message:@"Você ainda precisa escolher algumas coisas antes de marcar a consulta"];
    } else {
        [self.loadingView startLoading];
        [[ScheduleAppointmentProvider new] scheduleAppointmentWithService:[self.servicePickerView getSelectedOptionValue]
                                                                     date:[self.datePickerView getSelectedOptionValue]
                                                                     time:[self.timePickerView getSelectedOptionValue]
                                                                 callback:self];
    }
}
#pragma mark - lazy instantiations
-(AvailableTimesProvider *)timesProvider
{
    if (!_timesProvider) _timesProvider = [AvailableTimesProvider new];
    return _timesProvider;
}
@end