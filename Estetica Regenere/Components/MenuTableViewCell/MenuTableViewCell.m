//
//  MenuTableViewCell.m
//  Estetica Regenere
//
//  Created by Adriano on 10/15/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "MenuTableViewCell.h"

@interface MenuTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *bckView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *selectedIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation MenuTableViewCell

#pragma mark - public api
-(void)fillWithMenuOption:(MenuOption *)option
{
    [self fillWithName:option.name
                 image:option.imageName
         selectedImage:option.selectedImageName];
}

#pragma mark - hidden methods
-(void)fillWithName:(NSString *)name
              image:(NSString *)image
      selectedImage:(NSString *)selectedImage
{
    [self.titleLabel setText:name];
    [self.iconImageView setImage:[UIImage imageNamed:image]];
    [self.selectedIconImageView setImage:[UIImage imageNamed:selectedImage]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    //[self setSelectionStyle:UITableViewCellSelectionStyleNone];
    //[self setUnselected];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    selected ? [self setSelected] : [self setUnselected];

}

-(void)setSelected
{
    [self.titleLabel setTextColor:[UIColor whiteColor]];
    [self.iconImageView setHidden:YES];
    [self.selectedIconImageView setHidden:NO];
}

-(void)setUnselected
{
    [self.titleLabel setTextColor:[UIColor colorWithRed:61/255.0f green:145/255.0f blue:107.0f alpha:1.0]];
    [self.iconImageView setHidden:YES];
    [self.selectedIconImageView setHidden:NO];
}


@end
