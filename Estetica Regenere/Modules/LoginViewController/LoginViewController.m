//
//  LoginViewController.m
//  Estetica Regenere
//
//  Created by Adriano on 10/12/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "LoginViewController.h"
#import "RegenereTextField.h"
#import "BasicButtonView.h"
#import "LoadingView.h"
#import "LoginProvider.h"

@interface LoginViewController () <BasicButtonProtocol, LoginProviderDelegate>

@property (weak, nonatomic) IBOutlet RegenereTextField *emailRegenereTextFiel;
@property (weak, nonatomic) IBOutlet RegenereTextField *passwordRegenereTextField;
@property (weak, nonatomic) IBOutlet BasicButtonView *performLoginBasicButton;
@property (weak, nonatomic) IBOutlet LoadingView *loadingView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    [self setupForms];
    [self setupButtons];

}

#pragma mark - private methods
- (void) setupNavigationBar
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)setupForms
{
    [self.emailRegenereTextFiel setTitle:@"Email"];
    [self.passwordRegenereTextField setTitle:@"Senha"];
    [self.passwordRegenereTextField setSecure:YES];
}

-(void) setupButtons
{
    [self.performLoginBasicButton setType:BasicButtonTypeCallToAction];
    [self.performLoginBasicButton setTitle:@"Entrar no app"];
    [self.performLoginBasicButton setDelegate:self];
    
}

#pragma mark - BasicButtonDelegate
-(void)buttonTapped:(id)button
{
    if (button == self.performLoginBasicButton) {
        NSLog(@"FAZER LOGIN");
        [self.loadingView startLoading];
        [[LoginProvider new] performLoginWithEmail:[self.emailRegenereTextFiel getText] passord:[self.passwordRegenereTextField getText] delegate:self];
    }
}

#pragma mark - LoginProviderDelegate
-(void)onLoginSuccessWithToken:(NSString *)token
{
    
}

-(void)onLoginFailure
{
    
}

-(void)onNetworkFailure
{
    
}

-(void)onResponseFailure
{
    
}

@end
