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

@end

@implementation BasicButtonView

#pragma mark - Public API
- (void) setTitle:(NSString *)txt
{
    [self.txtLbl setText:txt];
}

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

- (void)setupLongPressGestureRecognizer {
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(buttonTapped:)];
    [longPressGesture setMinimumPressDuration:0.1f];
    [self addGestureRecognizer:longPressGesture];
}

-(void)buttonTapped:(UILongPressGestureRecognizer *)sender{
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:;
            [self.bckView setHidden:NO];
            break;

        case UIGestureRecognizerStateEnded:
            [self.bckView setHidden:YES];
            [self.delegate buttonTapped:self];
            break;
        default:
            break;
    }
}

@end
