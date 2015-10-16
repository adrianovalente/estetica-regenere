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

@interface MenuViewController () <MenuTableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *menuTableView;
@property (strong, nonatomic) MenuTableViewManager *manager;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *menuOptions = [[MenuProvider new] getMenuOptions];
    [self.manager updateWithData:menuOptions];
}


#pragma mark - Menu table view delegate
-(void)didSelectMenuOption:(NSInteger)option
{
    NSLog([NSString stringWithFormat:@"OPÇÃO: %d", option]);
}

#pragma mark - lazy instatiantions
-(MenuTableViewManager *)manager
{
    if (!_manager) _manager = [[MenuTableViewManager alloc] initWithTableView:self.menuTableView];
    return _manager;
}

@end
