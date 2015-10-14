//
//  BasicButtonView.m
//  Estetica Regenere
//
//  Created by Adriano on 10/10/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "BasicButtonView.h"


@interface BasicButtonView ()

@property (weak, nonatomic) IBOutlet UILabel *txtLbl;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (weak, nonatomic) IBOutlet UIView *bckView;

@end

@implementation BasicButtonView {
    BasicButtonType _type;
}

#pragma mark - Public API

- (void) setType:(BasicButtonType)type
{
    [self.bckView setHidden:NO];
    _type = type;
    if (type == BasicButtonTypeCallToAction) {
        [self.arrowImageView setImage:[UIImage imageNamed:@"button-arrow"]];
        [self.bckView setBackgroundColor:[UIColor colorWithRed:81/250.0f green:151/250.0f blue:130/250.0f alpha:1.0]];
        [self.txtLbl setTextColor:[UIColor whiteColor]];
        return;
    }
    
    if (type == BasicButtonTypeNormal) {
        [self.arrowImageView setImage:[UIImage imageNamed:@"green-button-arrow"]];
        [self.bckView setBackgroundColor:[UIColor colorWithRed:224/250.0f green:224/250.0f blue:224/250.0f alpha:1]];
        [self.txtLbl setTextColor:[UIColor colorWithRed:81/250.0f green:151/250.0f blue:130/250.0f alpha:1.0]];
        return;
    }
}
- (void) setTitle:(NSString *)txt
{
    [self.txtLbl setText:txt];
}

#pragma mark - Lifecycle

- (void)drawRect:(CGRect)rect
{
    self.layer.cornerRadius = 12;
    self.layer.masksToBounds = YES;
}

- (void) awakeFromNib
{
    [super awakeFromNib];
    [self setupLongPressGestureRecognizer];
}

#pragma mark - Private methods
- (void)setupLongPressGestureRecognizer {
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(buttonTapped:)];
    [longPressGesture setMinimumPressDuration:0.1f];
    [self addGestureRecognizer:longPressGesture];
}

-(void)buttonTapped:(UILongPressGestureRecognizer *)sender{
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            if (_type == BasicButtonTypeNormal) {
                [self.bckView setBackgroundColor:[UIColor colorWithRed:208/250.0f green:208/250.0f blue:208/250.0f alpha:1]];
            } else {
                [self.bckView setBackgroundColor:[UIColor colorWithRed:61/250.0f green:131/250.0f blue:110/250.0f alpha:1.0]];
            }
            break;

        case UIGestureRecognizerStateEnded:
            [self setType:_type];
            [self.delegate buttonTapped:self];
            break;
        default:
            break;
    }
}

@end
