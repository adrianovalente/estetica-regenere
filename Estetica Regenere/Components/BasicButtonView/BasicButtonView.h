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

typedef enum BasicButtonType : int {
    BasicButtonTypeNormal,
    BasicButtonTypeCallToAction
} BasicButtonType;

@property id<BasicButtonProtocol> delegate;

- (void) setTitle:(NSString *)txt;
- (void) setType:(BasicButtonType)type;

@end

