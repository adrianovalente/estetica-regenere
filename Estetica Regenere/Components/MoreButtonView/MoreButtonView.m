//
//  MoreButtonView.m
//  Estetica Regenere
//
//  Created by Adriano on 10/14/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "MoreButtonView.h"

@implementation MoreButtonView

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setupTapRecognizer];
}

#pragma mark - private methods
-(void) setupTapRecognizer
{
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonTapped:)]];
}

-(void)buttonTapped:(id)sender
{
    [self.delegate didTapMoreButton];
}
@end
