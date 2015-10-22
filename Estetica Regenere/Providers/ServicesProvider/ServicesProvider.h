//
//  ServicesProvider.h
//  Estetica Regenere
//
//  Created by Adriano on 10/22/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "BaseProvider.h"

@protocol ServicesProviderCallback <BaseProviderCallback>

-(void)onGetServicesSuccess:(NSArray *)services;

@end

@interface ServicesProvider : BaseProvider

-(void)getServicesWithAreaId:(NSString *)areaId callback:(id<ServicesProviderCallback>)callback;

@end
