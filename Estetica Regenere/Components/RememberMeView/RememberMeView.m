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
    [super drawRect:rect];
    [self setupShadow];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setupShadow];
}

- (void) setupShadow
{
    self.layer.masksToBounds = NO;
    self.layer.shadowOffset = CGSizeMake(0, -5);
    self.layer.shadowRadius = 5;
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    
}

@end
