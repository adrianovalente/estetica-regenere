//
//  LoginViewController.h
//  Estetica Regenere
//
//  Created by Adriano on 10/12/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "ViewController.h"

@protocol LoginViewControllerCallback <NSObject>
-(void)dismissLoginViewController;
@end

@interface LoginViewController : ViewController
-(instancetype)initWithDelegate:(id<LoginViewControllerCallback>)delegate;
@end
