//
//  UnderConstructionViewController.m
//  Estetica Regenere
//
//  Created by Adriano on 10/11/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "UnderConstructionViewController.h"
#import "BasicButtonView.h"

@interface UnderConstructionViewController () <BasicButtonProtocol>

@property (weak, nonatomic) IBOutlet BasicButtonView *button;

@end

@implementation UnderConstructionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.button setTitle:@"Voltar"];
    [self.button setDelegate:self];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - BasicButtonDelegate
-(void) buttonTapped:(id)button
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
