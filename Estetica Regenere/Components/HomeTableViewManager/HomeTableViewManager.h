//
//  HomeTableViewManager.h
//  Estetica Regenere
//
//  Created by Adriano on 10/11/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "BaseTableViewManager.h"

@protocol HomeTableViewManagerDelegate

- (void)didSelectConsulta:(NSInteger)consultaId;

@end

@interface HomeTableViewManager : BaseTableViewManager

@property (nonatomic) id<HomeTableViewManagerDelegate> delegate;

@end
