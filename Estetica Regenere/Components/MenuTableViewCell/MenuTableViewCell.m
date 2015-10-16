//
//  MenuTableViewCell.m
//  Estetica Regenere
//
//  Created by Adriano on 10/15/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "MenuTableViewCell.h"

@interface MenuTableViewCell ()

@end


@implementation MenuTableViewCell {
    __weak IBOutlet UIImageView *_iconImage;
    __weak IBOutlet UIView *_bckView;
    __weak IBOutlet UILabel *_titleLabel;
    __strong NSString *_iconImageName;
}

-(void)fillWithMenuOption:(MenuOption *)option
{
    [_titleLabel setText:option.name];
    _iconImageName = option.imageName;
    
}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    //selected ? [self setSelected] : [self setUnselected];
}

#pragma mark - private methods
-(void) setSelected
{
    [_bckView setBackgroundColor:[UIColor colorWithRed:61/255.0f green:145/255.0f blue:107/255.0f alpha:1.0]];
    [_titleLabel setTextColor:[UIColor whiteColor]];
    [_iconImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@-selected", _iconImageName]]];
}

-(void) setUnselected
{
    [_bckView setBackgroundColor:[UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1.0]];
    [_titleLabel setTextColor:[UIColor colorWithRed:61/255.0f green:145/255.0f blue:107/255.0f alpha:1.0]];
    [_iconImage setImage:[UIImage imageNamed:_iconImageName]];
}

@end
