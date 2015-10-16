//
//  RegenereTextField.m
//  Estetica Regenere
//
//  Created by Adriano on 10/13/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "RegenereTextField.h"
#import "JVFloatLabeledTextField.h"

@interface RegenereTextField ()

@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *txtField;
@property (weak, nonatomic) IBOutlet UIView *bckView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end


@implementation RegenereTextField

-(NSString *)getText
{
    return [self.txtField text];
}

-(void)setTitle:(NSString *)title
{
    [self.titleLabel setText:title];
    //[self.txtField setPlaceholder:title floatingTitle:title];
}

-(void)setSecure:(BOOL)secure
{
    [self.txtField setSecureTextEntry:secure];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
    
}

-(void)setup
{
    [self setupBackgroundView];
    //[self setupJVTextField];
}

-(void)setupBackgroundView
{
    self.bckView.layer.cornerRadius = 12;
    self.bckView.layer.masksToBounds = YES;
    self.bckView.layer.borderColor = [[UIColor colorWithRed:(61/255.0) green:(145/255.0) blue:(107/255.0) alpha:1] CGColor];
    self.bckView.layer.borderWidth = 1.0f;
}

-(void) setupJVTextField
{
    self.txtField.floatingLabelFont = [UIFont fontWithName:@"Gill Sans" size:12];
    self.txtField.floatingLabelTextColor = [UIColor colorWithRed:(61/255.0) green:(145/255.0) blue:(107/255.0) alpha:1];
}

@end
