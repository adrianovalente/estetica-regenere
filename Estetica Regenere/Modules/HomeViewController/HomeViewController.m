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

@interface HomeViewController () <HomeTableViewManagerDelegate, HomeHeaderViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *consultasTableView;
@property (weak, nonatomic) IBOutlet HomeHeaderView *header;
@property (strong, nonatomic) HomeTableViewManager *homeTableViewManager;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self unselectAllCells];
}


# pragma mark - Setup methods
- (void)setup
{
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
    //[self.navigationController.navigationBar setBackgroundImage:[[UINavigationBar appearance] backgroundImageForBarMetrics:UIBarMetricsDefault] forBarMetrics:UIBarMetricsDefault];
    //[self.navigationController.navigationBar setTranslucent:[[UINavigationBar appearance] isTranslucent]];
    //[self.navigationController.navigationBar setShadowImage:[[UINavigationBar appearance] shadowImage]];
    
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

#pragma mark - Lazy instantiation
-(HomeTableViewManager *) homeTableViewManager
{
    if (!_homeTableViewManager) _homeTableViewManager = [[HomeTableViewManager alloc] initWithTableView:self.consultasTableView];
    return _homeTableViewManager;
}

@end
