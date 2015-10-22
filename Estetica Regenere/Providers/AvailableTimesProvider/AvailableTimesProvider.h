//
//  AvailableTimesProvider.h
//  Estetica Regenere
//
//  Created by Adriano on 10/22/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "BaseProvider.h"

@protocol AvailableTimesProviderCallback <BaseProviderCallback>
-(void)onGetAvailableTimesSuccess;
-(void)onTokenMissing;
@end

@interface AvailableTimesProvider : BaseProvider

-(void)getAbailableTimesToService:(NSString *)service callback:(id<AvailableTimesProviderCallback>)callback;

-(NSArray *)getDates;
-(NSArray *)getTimesToDate:(NSString *)date;
@end
