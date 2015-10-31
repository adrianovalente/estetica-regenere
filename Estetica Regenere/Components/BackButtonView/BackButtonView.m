//
//  BackButtonView.m
//  Estetica Regenere
//
//  Created by Adriano on 10/31/15.
//  Copyright © 2015 Adriano. All rights reserved.
//

#import "BackButtonView.h"

@implementation BackButtonView

#pragma mark - setup methods
-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

-(void)setup
{
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)]];
}

#pragma mark - selector
-(void)tapped:(id)sender
{
    [self.delegate backButtonWasClicked];
}

@end
