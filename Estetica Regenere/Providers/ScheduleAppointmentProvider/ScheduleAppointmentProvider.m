//
//  ScheduleAppointmentProvider.m
//  Estetica Regenere
//
//  Created by Adriano on 10/22/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "ScheduleAppointmentProvider.h"

@implementation ScheduleAppointmentProvider

- (void)getAreasWithCallback:(id<ScheduleAppointmentProviderCallback>)callback
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"user-token"];
    if (token != nil && ![token isEqual:[NSNull null]]) {
        NSDictionary *authHeaders = @{
                                      @"regeneretoken": token
                                      };
        
        [self performRequestWithPath:@"/getAreas"
                             headers:authHeaders
                                data:@{}
                              method:@"GET"
                            callback:callback];
    } else {
        [callback onTokenMissing];
    }
}

@end
