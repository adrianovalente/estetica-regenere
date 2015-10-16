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
#import "HomeViewController.h"

@interface LoginViewController () <BasicButtonProtocol, LoginProviderDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet RegenereTextField *emailRegenereTextFiel;
@property (weak, nonatomic) IBOutlet RegenereTextField *passwordRegenereTextField;
@property (weak, nonatomic) IBOutlet BasicButtonView *performLoginBasicButton;
@property (weak, nonatomic) IBOutlet LoadingView *loadingView;
@property (strong, nonatomic) id<LoginViewControllerCallback> delegate;

@end

@implementation LoginViewController

-(instancetype)initWithDelegate:(id<LoginViewControllerCallback>)delegate
{
    self = [super init];
    [self setDelegate:delegate];
    return self;
}

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

-(void) displayAlertWithTitle:(NSString *)title message:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

#pragma mark - BasicButtonDelegate
-(void)buttonTapped:(id)button
{
    if (button == self.performLoginBasicButton) {
        [self.loadingView startLoading];
        [[LoginProvider new] performLoginWithEmail:[self.emailRegenereTextFiel getText] passord:[self.passwordRegenereTextField getText] delegate:self];
    }
}

#pragma mark - LoginProviderDelegate
-(void)onLoginSuccessWithToken:(NSString *)token
{
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"user-token"];
    [self.loadingView stopLoading];
    [self.delegate dismissLoginViewController];

}

-(void)onLoginFailure
{
    [self displayAlertWithTitle:@"Erro no login" message:@"Verifique se o e-mail e a senha estão certos"];
}

-(void)onNetworkFailure
{
    [self displayAlertWithTitle:@"Erro na rede" message:@"Não possível se conectar à Internet"];
}

-(void)onResponseFailure
{
    [self displayAlertWithTitle:@"Erro na rede" message:@"Não foi possível efetuar login. Por favor tente mais tarde."];
}

#pragma mark - AlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.loadingView stopLoading];
}
@end
