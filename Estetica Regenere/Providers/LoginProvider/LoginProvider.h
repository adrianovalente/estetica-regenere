//
//  LoginProvider.h
//  Estetica Regenere
//
//  Created by Adriano on 10/14/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseProvider.h"

@protocol LoginProviderDelegate <BaseProviderCallback>

-(void) onLoginSuccessWithToken:(NSString *)token;
-(void) onLoginFailure;

@end

@interface LoginProvider : BaseProvider

@property (nonatomic) id<LoginProviderDelegate> delegate;

-(void)performLoginWithEmail:(NSString *)email
                     passord:(NSString *)password
                    delegate:(id<LoginProviderDelegate>)delegate;

@end