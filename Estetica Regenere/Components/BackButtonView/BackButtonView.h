//
//  BackButtonView.h
//  Estetica Regenere
//
//  Created by Adriano on 10/31/15.
//  Copyright © 2015 Adriano. All rights reserved.
//

#import "BaseComponentsView.h"

@protocol BackButtonDelegate <NSObject>

-(void)backButtonWasClicked;

@end

@interface BackButtonView : BaseComponentsView

@property (nonatomic) id<BackButtonDelegate> delegate;

@end
