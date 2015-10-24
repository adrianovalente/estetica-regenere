//
//  SignUpViewController.h
//  Estetica Regenere
//
//  Created by Adriano on 10/24/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "ViewController.h"

@protocol SignUpViewControllerDelegate <NSObject>

-(void)onSignUpSuccessWithEmail:(NSString *)email
                       password:(NSString *)password;

@end


@interface SignUpViewController : ViewController

+ (SignUpViewController *)signUpViewControllerWithDelegate:(id<SignUpViewControllerDelegate>)delegate;

@end
