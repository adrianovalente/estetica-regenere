//
//  LoginFormView.m
//  Estetica Regenere
//
//  Created by Adriano on 10/20/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "LoginFormView.h"
#import "JVFloatLabeledTextField.h"

@interface LoginFormView ()


@property (weak, nonatomic) IBOutlet UIView *bckView;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *loginTextField;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *paaswordTextField;


@end

@implementation LoginFormView

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setupBorders];
    [self setupTextFields];
}

-(void)setupBorders
{
    self.bckView.layer.cornerRadius = 5;
    self.bckView.layer.masksToBounds = YES;
    self.bckView.layer.borderColor = [[UIColor colorWithRed:(61/255.0) green:(145/255.0) blue:(107/255.0) alpha:1] CGColor];
    self.bckView.layer.borderWidth = 1.0f;
}

-(void)setupTextFields
{
    [self.loginTextField setPlaceholder:@"Email" floatingTitle:@"Email"];
    [self.loginTextField setFloatingLabelActiveTextColor:[UIColor colorWithRed:61/255.0f green:145/255.0f blue:107/255.0f alpha:1.0]];
    [self.paaswordTextField setPlaceholder:@"Senha" floatingTitle:@"Senha"];
    [self.paaswordTextField setFloatingLabelActiveTextColor:[UIColor colorWithRed:61/255.0f green:145/255.0f blue:107/255.0f alpha:1.0]];
    [self.paaswordTextField setSecureTextEntry:YES];
    
}

#pragma mark - public api
-(NSString *)getEmail
{
    return self.loginTextField.text;
}

-(NSString *)getPassword
{
    return self.paaswordTextField.text;
}



@end
