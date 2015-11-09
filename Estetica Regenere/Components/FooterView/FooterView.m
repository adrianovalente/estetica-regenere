//
//  FooterView.m
//  Estetica Regenere
//
//  Created by Adriano on 10/16/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "FooterView.h"
#import "Constants.h"

@interface FooterView ()
@property (weak, nonatomic) IBOutlet UIView *byLabel;
@end

@implementation FooterView

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setupByLabel];
}

-(void)setupByLabel
{
    [self.byLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(byLabelTapped)]];
}

-(void)byLabelTapped
{
    NSURL *url = [NSURL URLWithString:[apiHostName stringByAppendingString:@"/about_me"]];
    [[UIApplication sharedApplication] openURL:url];
}
@end
