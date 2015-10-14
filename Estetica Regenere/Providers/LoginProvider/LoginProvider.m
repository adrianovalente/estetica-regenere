//
//  LoginProvider.m
//  Estetica Regenere
//
//  Created by Adriano on 10/14/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "LoginProvider.h"
#import "AFHTTPRequestOperationManager.h"

@implementation LoginProvider

-(void)performLoginWithEmail:(NSString *)email
                     passord:(NSString *)password
                    delegate:(id<LoginProviderDelegate>)delegate
{
    NSDictionary *body = @{
                           @"email": email,
                           @"password": password
                           };
    
    [self performRequestWithPath:@"/login/"
                          headers:@{}
                             data:body
                           method:@"POST"
                        callback:delegate];
}


-(void)handleSuccesfulResponse:(NSDictionary *)response callback:(id)callback
{
    [callback onLoginSuccessWithToken:response[@"content"][@"token"]];
}

-(void)handleFailedResponse:(NSDictionary *)response callback:(id)callback
{
    [callback onLoginFailure];
}


@end