//
//  AreasProvider.h
//  Estetica Regenere
//
//  Created by Adriano on 10/22/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "BaseProvider.h"

@protocol AreasProviderCallback <BaseProviderCallback>

-(void)onGetAreasSuccess:(NSArray *)areas;

@end

@interface AreasProvider : BaseProvider

@property (nonatomic)  id<AreasProviderCallback>callback;

-(void)getAreasWithCallback:(id<AreasProviderCallback>)callback;

@end
