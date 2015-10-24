//
//  SignUpProvider.h
//  Estetica Regenere
//
//  Created by Adriano on 10/24/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "BaseProvider.h"

@protocol SignupProviderCallback <BaseProviderCallback>

-(void)onSignUpSuccess;
-(void)onInvalidVerificationCode;
-(void)onEmailAlreadyUsed;
-(void)onNotAClient;

@end

@interface SignUpProvider : BaseProvider

-(void)performSignUpWithEmail:(NSString *)email
                     password:(NSString *)password
             verificationCode:(NSString *)code
                     callback:(id<SignupProviderCallback>)callback;

@end
