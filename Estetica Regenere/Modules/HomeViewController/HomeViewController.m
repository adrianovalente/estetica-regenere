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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
