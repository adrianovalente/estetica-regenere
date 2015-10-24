//
//  SignUpFormView.h
//  Estetica Regenere
//
//  Created by Adriano on 10/24/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "BaseComponentsView.h"

@interface SignUpFormView : BaseComponentsView

-(NSString *)getEmail;
-(NSString *)getPassword;
-(NSString *)getVerificationCode;
-(BOOL)validate;

@end
