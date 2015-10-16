//
//  DeleteAppointmentProvider.m
//  Estetica Regenere
//
//  Created by Adriano on 10/16/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "DeleteAppointmentProvider.h"

@implementation DeleteAppointmentProvider

-(void)deleteAppointmentWithId:(int)appointmentId callback:(id<DeleteAppointmentCallback>)callback
{
    
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"user-token"];
    if (token != nil && ![token isEqual:[NSNull null]]) {
        NSDictionary *authHeaders = @{
                                      @"regeneretoken": token
                                      };
        
        [self performRequestWithPath:[NSString stringWithFormat:@"/delete_appointment/%d", appointmentId]
                             headers:authHeaders
                                data:@{}
                              method:@"GET"
                            callback:callback];
    } else {
        [callback onTokenMissing];
    }
}

#pragma mark - abstract methods implementations
-(void)handleSuccesfulResponse:(NSDictionary *)response callback:(id)callback
{
    [callback onDeleteAppointmentSuccess];
}

-(void)handleFailedResponse:(NSDictionary *)response callback:(id)callback
{
    [callback onDeleteAppointmentFailure];
}

@end
