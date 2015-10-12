//
//  HomeTableViewCell.m
//  Estetica Regenere
//
//  Created by Adriano on 10/11/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "HomeTableViewCell.h"


@interface HomeTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *serviceNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@end

@implementation HomeTableViewCell

- (void)fillCellWithName:(NSString *)name subtitle:(NSString *)subtitle time:(NSString *)time
{
    [self.serviceNameLabel setText:name];
    [self.subtitleLabel setText:subtitle];
    [self.timeLabel setText:time];
}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleGray;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
