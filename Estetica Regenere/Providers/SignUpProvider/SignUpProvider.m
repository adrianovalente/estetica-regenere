//
//  SignUpProvider.m
//  Estetica Regenere
//
//  Created by Adriano on 10/24/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "SignUpProvider.h"

@implementation SignUpProvider

#pragma mark - public api
-(void)performSignUpWithEmail:(NSString *)email
                     password:(NSString *)password
             verificationCode:(NSString *)code
                     callback:(id<SignupProviderCallback>)callback
{
    NSDictionary *data = @{
                           @"email": email,
                           @"password": password,
                           @"code":code
                           };
    
    [self performRequestWithPath:@"/signup/" headers:@{} data:data method:@"POST" callback:callback];
}

#pragma mark - abstract methods implementations (overwrite)
-(void)handleSuccesfulResponse:(NSDictionary *)response callback:(id)callback
{
    [callback onSignUpSuccess];
}

-(void)handleFailedResponse:(NSDictionary *)response callback:(id)callback
{
    NSString *codeError = [[response objectForKey:@"content"] objectForKey:@"error"];
    
    if ([codeError isEqualToString:@"CODE_NOT_VALID"])
        return [callback onInvalidVerificationCode];
    
    if ([codeError isEqualToString:@"EMAIL_ALREADY_USED"])
        return [callback onEmailAlreadyUsed];
    
    if ([codeError isEqualToString:@"NOT_A_CLIENT"])
        return [callback onNotAClient];
}



@end
