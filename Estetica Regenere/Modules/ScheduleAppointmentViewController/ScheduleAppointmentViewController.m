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

@interface ScheduleAppointmentViewController () <BaseHeaderViewDelegate>
@property (weak, nonatomic) IBOutlet BaseHeaderView *header;
@end

@implementation ScheduleAppointmentViewController

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
}

-(void)setup
{
    [self setupNavBar];
    [self setupHeader];
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

#pragma mark - Base Header View Delegate
-(void)didTapMenuButton
{
    [(JASidePanelController *)self.navigationController.parentViewController toggleLeftPanel:self];
}

@end