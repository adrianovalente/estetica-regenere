//
//  ScheduleAppointmentProvider.m
//  Estetica Regenere
//
//  Created by Adriano on 10/22/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "ScheduleAppointmentProvider.h"

@implementation ScheduleAppointmentProvider

- (void)scheduleAppointmentWithService:(NSString *)service
                                  date:(NSString *)date
                                  time:(NSString *)time
                              callback:(id<ScheduleAppointmentProviderCallback>)callback
{
    NSDictionary *data = @{
                           @"service": service,
                           @"time": [NSString stringWithFormat:@"%@-%@", date, time]
                           };
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"user-token"];
    if (token != nil && ![token isEqual:[NSNull null]]) {
        NSDictionary *authHeaders = @{
                                      @"regeneretoken": token
                                      };
        
        [self performRequestWithPath:@"/schedule/"
                             headers:authHeaders
                                data:data
                              method:@"POST"
                            callback:callback];
    } else {
        [callback onTokenMissing];
    }
}

#pragma mark - overriding abstract methods
-(void)handleSuccesfulResponse:(NSDictionary *)response callback:(id)callback
{
    [callback onScheduleAppointmentSuccess];
}

-(void)handleFailedResponse:(NSDictionary *)response callback:(id)callback
{
    if ([[[response objectForKey:@"content"] objectForKey:@"error"] isEqualToString:@"TIME_NOT_AVAILABLE"]) {
        return [callback onTimeNotAvailable];
    }
    [callback onResponseFailure];
}

@end
