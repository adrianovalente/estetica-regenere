//
//  ContactViewController.m
//  Estetica Regenere
//
//  Created by Adriano on 10/16/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "ContactViewController.h"
#import "BaseHeaderView.h"
#import "JASidePanelController.h"
#import "MenuViewController.h"

@interface ContactViewController () <BaseHeaderViewDelegate>
@property (weak, nonatomic) IBOutlet BaseHeaderView *header;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addresLabel;
@property (weak, nonatomic) IBOutlet UIView *callView;

@end

@implementation ContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    JASidePanelController *panelController = (JASidePanelController *)self.navigationController.parentViewController;
    [(MenuViewController *)panelController.leftPanel selectCell:3];
}

-(void)setup
{
    [self setupNavBar];
    [self setupHeader];
    [self setupLabels];
    [self setupCallView];
}

- (void) setupNavBar
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}


-(void)setupHeader
{
    [self.header setDelegate:self];
    [self.header updateDescriptionLabel:@"Quer falar com a gente?"];
    [self.header updateWithName:[[NSUserDefaults standardUserDefaults] objectForKey:@"user-name"]];
    
}

-(void)setupLabels
{
    [self.timeLabel setNumberOfLines:0];
    [self.timeLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.addresLabel setNumberOfLines:0];
    [self.addresLabel setLineBreakMode:NSLineBreakByWordWrapping];
}

-(void)setupCallView
{
    [self.callView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callTapped)]];
}

-(void)callTapped
{
    NSLog(@"LIGAR");
    NSString *phoneCallNum = [NSString stringWithFormat:@"tel://26688020"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneCallNum]];
}

#pragma mark - Base Header View Delegate
-(void)didTapMenuButton
{
    [(JASidePanelController *)self.navigationController.parentViewController toggleLeftPanel:self];
}

@end
