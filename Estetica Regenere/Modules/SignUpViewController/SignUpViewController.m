//
//  SignUpViewController.m
//  Estetica Regenere
//
//  Created by Adriano on 10/24/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "SignUpViewController.h"
#import "BasicButtonView.h"
#import "SignUpProvider.h"
#import "SignUpFormView.h"
#import "LoadingView.h"

@interface SignUpViewController () <BasicButtonProtocol, SignupProviderCallback>
@property (weak, nonatomic) IBOutlet BasicButtonView *signUpButton;
@property (weak, nonatomic) IBOutlet SignUpFormView *formView;
@property (weak, nonatomic) IBOutlet LoadingView *loadingView;

@end

@implementation SignUpViewController {
    id<SignUpViewControllerDelegate> _delegate;
}

#pragma mark - init and setup methods
+ (SignUpViewController *)signUpViewControllerWithDelegate:(id<SignUpViewControllerDelegate>)delegate {
    return [[SignUpViewController alloc] initWithDelegate:delegate];
}

-(instancetype)initWithDelegate:(id<SignUpViewControllerDelegate>)delegate
{
    self = [super init];
    _delegate = delegate;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

-(void)setup
{
    [self setupSignUpButton];
}

-(void)setupSignUpButton
{
    [self.signUpButton setTitle:@"Cadastrar"];
    [self.signUpButton setType:BasicButtonTypeCallToAction];
    [self.signUpButton setDelegate:self];
}

#pragma mark - Basic Button Delegate
- (void)buttonTapped:(id)button
{
    if ([self.formView validate]) {
        [self.loadingView startLoading];
        [[SignUpProvider new] performSignUpWithEmail:[self.formView getEmail]
                                            password:[self.formView getPassword]
                                    verificationCode:[self.formView getVerificationCode]
                                            callback:self];
    }
}

#pragma mark - SignUp Callback
- (void)onInvalidVerificationCode
{
    [self showAlertWithTitle:@"Código inválido"
                     message:@"Opa! Parece que você digitou um código de verificação inválido."];
    [self.loadingView stopLoading];
}

- (void)onEmailAlreadyUsed
{
    [self showAlertWithTitle:@"Email já utilizado"
                     message:@"Esse e-mail já foi utilizado por uma outra conta. Se tiver dificuldades com o cadastro entre em contato conosco."];
    [self.loadingView stopLoading];
}

- (void)onNetworkFailure
{
    [self showAlertWithTitle:@"Falha na rede"
                     message:@"Não foi possível acessar a Interent"];
    [self.loadingView stopLoading];
}

- (void)onNotAClient
{
    [self showAlertWithTitle:@"Email não registrado"
                     message:@"Opa! Parece que você ainda não é um cliente. Faça o seu pré-cadastro presencial com uma de nossas atendentes"];
    [self.loadingView stopLoading];
}

- (void)onResponseFailure
{
    [self onNetworkFailure];
}

- (void)onSignUpSuccess
{
    [_delegate onSignUpSuccessWithEmail:[self.formView getEmail]
                               password:[self.formView getPassword]];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - another private method
-(void)showAlertWithTitle:(NSString *)title
                  message:(NSString *)message
{
    [[[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
}

@end
