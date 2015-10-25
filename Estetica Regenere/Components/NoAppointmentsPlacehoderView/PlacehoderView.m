//
//  NoAppointmentsPlacehoderView.m
//  Estetica Regenere
//
//  Created by Adriano on 10/24/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "PlacehoderView.h"
#import "BasicButtonView.h"

typedef enum:int {
    PlaceHolderTypeNoConnection,
    PlaceHolderTypeNoAppointment
}PlaceholderType;

@interface PlacehoderView () <BasicButtonProtocol>

// TODO: 
//@property (weak, nonatomic) IBOutlet BasicButtonView *scheduleButton;

@end

@implementation PlacehoderView {
    
    __weak IBOutlet NSLayoutConstraint *_heightConstraint;
    __weak IBOutlet NSLayoutConstraint *labelConstraint;
    __weak IBOutlet UIImageView *_image;
    __weak IBOutlet UILabel *_titleLabel;
    __weak IBOutlet BasicButtonView *_scheduleButton;
    PlaceholderType _currentType;
    
}

#pragma mark - public api
- (void)showNoAppointmentsPlaceholder
{
    [_scheduleButton setTitle:@"Vou marcar!"];
    [_heightConstraint setConstant:120];
    [labelConstraint setConstant:3];
    [_image setImage:[UIImage imageNamed:@"calendar-placehoder"]];
    [_titleLabel setText:@"Opa! Parece que por enquanto você ainda não tem nenhuma consulta!"];
    [self setHidden:NO];
    _currentType = PlaceHolderTypeNoAppointment;
}

- (void)showNoConnectionPlaceHolder
{
    [_scheduleButton setTitle:@"Tentar de novo"];
    [labelConstraint setConstant:10];
    [_heightConstraint setConstant:95];
    [_image setImage:[UIImage imageNamed:@"wifi-placeholder"]];
    [_titleLabel setText:@"Poxa! Parece que você está sem Internet!"];
    [self setHidden:NO];
    _currentType = PlaceHolderTypeNoConnection;
}
- (void)hide
{
    [self setHidden:YES];
}

#pragma mark - setup methods
-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setupLabel];
    [self setupButton];
    [self setHidden:YES];
}

-(void)setupButton
{
    [_scheduleButton setType:BasicButtonTypeCallToAction];
    [_scheduleButton setDelegate:self];
}

-(void)setupLabel
{
    _titleLabel.numberOfLines = 0;
    _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
}


#pragma mark - Basic Button Delegate
- (void)buttonTapped:(id)button
{
    if (_currentType == PlaceHolderTypeNoAppointment) {
        return [self.delegate scheduleAppointmentButtonPressed];
    }
    
    if (_currentType == PlaceHolderTypeNoConnection) {
        [self.delegate tryAgainButtonPressed];
    }
}

@end
