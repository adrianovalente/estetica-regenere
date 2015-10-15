//
//  MoreButtonView.h
//  Estetica Regenere
//
//  Created by Adriano on 10/14/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "BaseComponentsView.h"

@protocol MoreButtonDelegate <NSObject>

-(void)didTapMoreButton;

@end

@interface MoreButtonView : BaseComponentsView
@property (nonatomic) id<MoreButtonDelegate> delegate;
@end
