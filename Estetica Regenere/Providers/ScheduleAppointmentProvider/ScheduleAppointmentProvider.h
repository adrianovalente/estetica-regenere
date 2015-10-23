//
//  ScheduleAppointmentProvider.h
//  Estetica Regenere
//
//  Created by Adriano on 10/22/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "BaseProvider.h"

@protocol ScheduleAppointmentProviderCallback <BaseProviderCallback>
-(void)onTokenMissing;
-(void)onTimeNotAvailable;
-(void)onScheduleAppointmentSuccess;
@end

@interface ScheduleAppointmentProvider : BaseProvider

-(void)scheduleAppointmentWithService:(NSString *)service
                                 date:(NSString *)date
                                 time:(NSString *)time
                             callback:(id<ScheduleAppointmentProviderCallback>)callback;

@end
