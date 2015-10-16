//
//  BaseHeaderView.m
//  Estetica Regenere
//
//  Created by Adriano on 10/16/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "BaseHeaderView.h"
#import "MoreButtonView.h"

@interface BaseHeaderView () <MoreButtonDelegate>

@property (weak, nonatomic) IBOutlet UILabel *helloLabel;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet MoreButtonView *moreButtonView;

@end

@implementation BaseHeaderView

#pragma mark - public api
-(void)updateWithName:(NSString *)username
{
    [self.helloLabel setText:[NSString stringWithFormat:@"Olá, %@", username]];
}

-(void)updateDescriptionLabel:(NSString *)text
{
    [self.textLabel setText:text];
}


#pragma mark - setup methods
-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setupMoreButtonView];
}

-(void)setupMoreButtonView
{
    [self.moreButtonView setDelegate:self];
}

#pragma mark - more button delegate
-(void)didTapMoreButton
{
    [self.delegate didTapMenuButton];
}



@end
