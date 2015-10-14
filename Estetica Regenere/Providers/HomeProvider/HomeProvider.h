//
//  HomeProvider.h
//  Estetica Regenere
//
//  Created by Adriano on 10/14/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "BaseProvider.h"


@protocol HomeProviderCallback <BaseProviderCallback>

-(void)onHomeRequestFailure;
-(void)onTokenMissing;
-(void)onHomeRequestSuccessWithName:(NSString *)name
                       appointments:(NSArray *)appointments
                           thisWeek:(NSNumber *)thisWeek;

@end

@interface HomeProvider : BaseProvider

@property (nonatomic) id<HomeProviderCallback>callback;

-(void)performHomeRequestWithCallback:(id<HomeProviderCallback>)callback;

@end
