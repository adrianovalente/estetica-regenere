//
//  BaseHeaderView.h
//  Estetica Regenere
//
//  Created by Adriano on 10/16/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "BaseComponentsView.h"

@protocol BaseHeaderViewDelegate <NSObject>

-(void)didTapMenuButton;

@end


@interface BaseHeaderView : BaseComponentsView

-(void)updateWithName:(NSString *)username;
-(void)updateDescriptionLabel:(NSString *)text;
@property (nonatomic) id<BaseHeaderViewDelegate> delegate;

@end
