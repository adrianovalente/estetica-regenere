//
//  BaseView.m
//  Netshoes
//
//  Created by Indigo on 4/24/15.
//  Copyright (c) 2015 Taqtile. All rights reserved.
//

#import "BaseComponentsView.h"

@implementation BaseComponentsView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self addContentViewWithConstraints];
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addContentViewWithConstraints];
    }
    return self;
}

-(void) addContentViewWithConstraints
{
    UIView * contentView = [[[NSBundle mainBundle] loadNibNamed:[[self class] description] owner:self options:nil] firstObject];
    
    [self addSubview:contentView];
    
    contentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *viewsMapping = @{@"view": contentView};
    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:viewsMapping];
    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:viewsMapping];
    
    [self addConstraints:horizontalConstraints];
    [self addConstraints:verticalConstraints];
}

@end
