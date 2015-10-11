//
//  BasicButtonView.h
//  Estetica Regenere
//
//  Created by Adriano on 10/10/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "BaseComponentsView.h"

@protocol BasicButtonProtocol

- (void)buttonTapped:(id)button;

@end

@interface BasicButtonView : BaseComponentsView

@property (weak, nonatomic) IBOutlet UIView *bckView;
@property id<BasicButtonProtocol> delegate;
- (void) setTitle:(NSString *)txt;

@end

