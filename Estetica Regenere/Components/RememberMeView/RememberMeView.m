//
//  RememberMeView.m
//  Estetica Regenere
//
//  Created by Adriano on 10/11/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "RememberMeView.h"
#import <QuartzCore/QuartzCore.h>

@implementation RememberMeView

- (void) drawRect:(CGRect)rect
{
    self.layer.masksToBounds = NO;
    self.layer.shadowOffset = CGSizeMake(-15, 20);
    self.layer.shadowRadius = 5;
    self.layer.shadowOpacity = 0.5;
    [self setup];
}

- (void) setup
{

}

@end
