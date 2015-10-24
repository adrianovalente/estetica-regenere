//
//  SignUpFormView.m
//  Estetica Regenere
//
//  Created by Adriano on 10/24/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "SignUpFormView.h"
#import "JVFloatLabeledTextField.h"

@interface SignUpFormView ()

@property (weak, nonatomic) IBOutlet UIView *borderView;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *emailTxtField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *passwordTextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *repeatPasswordTextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *confirmationCodeTextField;

@end

@implementation SignUpFormView

#pragma mark - public api
- (BOOL)validate
{
    if (![self NSStringIsValidEmail:self.emailTxtField.text]) {
        [self showAlertWithTitle:@"Email não válido"
                         message:@"Opa! Parece que seu email não é válido. Digite novamente por favor!"];
        return NO;
    }
    
    if ([self.passwordTextField.text isEqualToString:@""]) {
        [self showAlertWithTitle:@"Senha inválida"
                         message:@"Você precisa escolher alguma senha"];
        return NO;
    }
    
    if (![self.passwordTextField.text isEqualToString:self.repeatPasswordTextField.text]) {
        [self showAlertWithTitle:@"Senhas diferentes"
                         message:@"Opa! Parece que você digitou duas senhas diferentes. Confira isso antes de continuar!"];
        return NO;
    }
    
    if (![self isValidVerificationCode:self.confirmationCodeTextField.text]) {
        [self showAlertWithTitle:@"Código inválido"
                         message:@"Opa! Parece que você digitou um código de verificação inválido."];
        return NO;
    }
    
    return YES;
}

-(NSString *)getEmail
{
    return self.emailTxtField.text;
}

-(NSString *)getPassword
{
    return self.passwordTextField.text;
}

- (NSString *)getVerificationCode
{
    return self.confirmationCodeTextField.text;
}

#pragma mark - setup methods
-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setupBorderView];
    [self setupTextFields];
}

-(void)setupBorderView
{
    self.borderView.layer.cornerRadius = 5;
    self.borderView.layer.masksToBounds = YES;
    self.borderView.layer.borderColor = [[UIColor colorWithRed:(61/255.0) green:(145/255.0) blue:(107/255.0) alpha:1] CGColor];
    self.borderView.layer.borderWidth = 1.0f;
}

-(void)setupTextFields
{
    [self.emailTxtField setPlaceholder:@"Email" floatingTitle:@"Email"];
    [self.emailTxtField setFloatingLabelActiveTextColor:[UIColor colorWithRed:61/255.0f green:145/255.0f blue:107/255.0f alpha:1.0]];
    [self.passwordTextField setPlaceholder:@"Senha" floatingTitle:@"Senha"];
    [self.passwordTextField setFloatingLabelActiveTextColor:[UIColor colorWithRed:61/255.0f green:145/255.0f blue:107/255.0f alpha:1.0]];
    [self.passwordTextField setSecureTextEntry:YES];
    [self.repeatPasswordTextField setPlaceholder:@"Repita a senha" floatingTitle:@"Repita a senha"];
    [self.repeatPasswordTextField setFloatingLabelActiveTextColor:[UIColor colorWithRed:61/255.0f green:145/255.0f blue:107/255.0f alpha:1.0]];
    [self.repeatPasswordTextField setSecureTextEntry:YES];
    [self.confirmationCodeTextField setPlaceholder:@"Código de verificação" floatingTitle:@"Código de verificação"];
    [self.confirmationCodeTextField setFloatingLabelActiveTextColor:[UIColor colorWithRed:61/255.0f green:145/255.0f blue:107/255.0f alpha:1.0]];
}

#pragma mark - validation methods
-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

-(BOOL) isValidVerificationCode:(NSString *)checkString
{
    NSString *regex = @"^[0-9]{4}$";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [test evaluateWithObject:checkString];
}

#pragma mark - another private method
-(void)showAlertWithTitle:(NSString *)title
                  message:(NSString *)message
{
    [[[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
}

@end
