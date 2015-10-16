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

@implementation HomeTableViewCell {
    __weak IBOutlet UIView *_trashView;
}

- (void)fillCellWithName:(NSString *)name subtitle:(NSString *)subtitle time:(NSString *)time consultaId:(int)consultaId
{
    [self.serviceNameLabel setText:name];
    [self.subtitleLabel setText:subtitle];
    [self.timeLabel setText:time];
    [self setAppointmentId:consultaId];
}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    [self addRecognizerToTrashView];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
}

#pragma mark - private methods
-(void)addRecognizerToTrashView
{
    [_trashView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(trashTapped:)]];
}

-(void)trashTapped:(id)event
{
    //TODO: Add logic to send appointment ID as well
    [self.trashDelegate didTapTrashIcon:self.appointmentId];
}
@end
