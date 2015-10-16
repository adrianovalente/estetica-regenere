//
//  MenuViewController.m
//  Estetica Regenere
//
//  Created by Adriano on 10/15/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuTableViewManager.h"
#import "MenuProvider.h"
#import "JASidePanelController.h"
#import "HomeViewController.h"
#import "UnderConstructionViewController.h"
#import "LoginViewController.h"
#import "MenuTableViewCell.h"
#import "ScheduleAppointmentViewController.h"
#import "PrivacyPolicyViewController.h"
#import "ContactViewController.h"

@interface MenuViewController () <MenuTableViewDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *menuTableView;
@property (strong, nonatomic) MenuTableViewManager *manager;
@property (nonatomic) UIAlertView *logoutAlertView;

@end

@implementation MenuViewController {
    NSInteger _selectedOption;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *menuOptions = [[MenuProvider new] getMenuOptions];
    [self.manager updateWithData:menuOptions];
    [self.manager setDelegate:self];
    [self resetMenu];
}

#pragma mark - public api
-(void)resetMenu
{
    [self selectCell:0];
    
}

#pragma mark - Menu table view delegate
-(void)didSelectMenuOption:(NSInteger)option
{
    JASidePanelController *panelController = (JASidePanelController *)self.parentViewController;
    if (option == 0) {
        panelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:[HomeViewController new]];
        [self selectCell:0];
        _selectedOption = 0;
    }
    if (option == 1) {
        if (_selectedOption != 0) {
            panelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:[HomeViewController new]];
        }
            [(UINavigationController *)panelController.centerPanel pushViewController:[ScheduleAppointmentViewController new] animated:NO];
        
        [self selectCell:1];
        _selectedOption = 1;
    }
    if (option == 2) {
        if (_selectedOption != 0) {
            panelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:[HomeViewController new]];
        }
        [(UINavigationController *)panelController.centerPanel pushViewController:[PrivacyPolicyViewController new] animated:NO];
        
        [self selectCell:2];
        _selectedOption = 2;
        
    }
    if (option == 3) {
        if (_selectedOption != 0) {
            panelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:[HomeViewController new]];
        }
        [(UINavigationController *)panelController.centerPanel pushViewController:[ContactViewController new] animated:NO];
        
        [self selectCell:3];
        _selectedOption = 3;
        
    }
    
    [panelController showCenterPanelAnimated:YES];
    
    if (option == 4) {
        [self selectCell:4];
        [self.logoutAlertView show];
    }
}

#pragma mark - Alert View Delegate
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == self.logoutAlertView) {
        if (buttonIndex == 1) {
            [self performLogout];
            [self resetMenu];
        }
        [self selectCell:_selectedOption];
    }
}

#pragma mark - private methods
-(void) performLogout
{
    JASidePanelController *panelController = (JASidePanelController *)self.parentViewController;
    [panelController showCenterPanelAnimated:YES];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user-token"];
    panelController.centerPanel = [[UINavigationController alloc] initWithRootViewController:[[HomeViewController alloc] initFromLogout]];
}

- (void)unselectAllCells
{
    for (int section = 0; section < [self.menuTableView numberOfSections]; section++) {
        for (int row = 0; row < [self.menuTableView numberOfRowsInSection:section]; row++) {
            NSIndexPath* cellPath = [NSIndexPath indexPathForRow:row inSection:section];
            MenuTableViewCell* cell = (MenuTableViewCell *)[self.menuTableView cellForRowAtIndexPath:cellPath];
            [cell setUnselected];
        }
    }
}

-(void)selectCell:(NSInteger)row
{
    [self unselectAllCells];
    NSIndexPath* cellPath = [NSIndexPath indexPathForRow:row inSection:0];
    MenuTableViewCell* cell = (MenuTableViewCell *)[self.menuTableView cellForRowAtIndexPath:cellPath];
    [cell setSelected];
}

#pragma mark - lazy instatiantions
-(MenuTableViewManager *)manager
{
    if (!_manager) _manager = [[MenuTableViewManager alloc] initWithTableView:self.menuTableView];
    return _manager;
}

-(UIAlertView *)logoutAlertView
{
    if (!_logoutAlertView) _logoutAlertView = [[UIAlertView alloc] initWithTitle:@"Fazer logout" message:@"Tem certeza que deseja sair do aplicativo?" delegate:self cancelButtonTitle:@"Não" otherButtonTitles: @"Sim", nil];
    return _logoutAlertView;
}

@end
