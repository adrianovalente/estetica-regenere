//
//  RegenereTextField.h
//  Estetica Regenere
//
//  Created by Adriano on 10/13/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "BaseComponentsView.h"

@interface RegenereTextField : BaseComponentsView

-(void)setTitle:(NSString *)title;
-(void)setSecure:(BOOL)secure;
-(NSString *)getText;

@end