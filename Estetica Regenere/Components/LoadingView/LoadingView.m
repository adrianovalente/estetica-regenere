//
//  LoadingView.m
//  Estetica Regenere
//
//  Created by Adriano on 10/14/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "LoadingView.h"

@interface LoadingView ()

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIView *bckView;


@end

@implementation LoadingView

#pragma mark - setup methods
-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

-(void)setup
{
    [self stopLoading];
}

#pragma mark - public API
-(void)startLoading
{
    [self setLoading:YES];
}

-(void)stopLoading {
    [self setLoading:NO];
}


#pragma mark - private methods
-(void)setLoading:(BOOL)loading
{
//    [UIView animateWithDuration:0.5
//                          delay:0.0
//                        options: UIViewAnimationCurveEaseOut
//                     animations:^
//     {
//         [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//         if (hide)
//             self.bckView.alpha=0;
//         else
//         {
//             self.bckView.hidden= NO;
//             self.alpha=1;
//         }
//     }
//                     completion:^(BOOL b)
//     {
//         if (hide) {
//             self.bckView.hidden= YES;
//             [self.activityIndicator setHidden:YES];
//            [self.activityIndicator stopAnimating];
//         } else {
//             self.bckView.hidden = NO;
//             [self.activityIndicator startAnimating];
//             [self.activityIndicator setHidden:NO];
//         }
//     }
//     ];
//
    if (loading) {
        self.hidden = NO;
        [self.activityIndicator startAnimating];
    } else {
        [self.activityIndicator stopAnimating];
        self.hidden = YES;
    }
}


@end
