//
//  HomeHeaderView.h
//  Estetica Regenere
//
//  Created by Adriano on 10/10/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "BaseComponentsView.h"

@protocol HomeHeaderViewDelegate
- (void)didSelectMarcarConsulta;
@end

@interface HomeHeaderView : BaseComponentsView
@property (nonatomic) id<HomeHeaderViewDelegate> delegate;
@end
