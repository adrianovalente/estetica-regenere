//
//  HomeProvider.m
//  Estetica Regenere
//
//  Created by Adriano on 10/14/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "HomeProvider.h"
#import "AppointmentsList.h"

@implementation HomeProvider

#pragma mark - public api
-(void)performHomeRequestWithCallback:(id<HomeProviderCallback>)callback
{
    
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"user-token"];
    if (token != nil && ![token isEqual:[NSNull null]]) {
        NSDictionary *authHeaders = @{
                                      @"regeneretoken": token
                                      };
    
        [self performRequestWithPath:@"/home"
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
    NSDictionary *data = [response objectForKey:@"content"];
    AppointmentsList *list = [[AppointmentsList alloc] initWithDictionary:data error:nil];
    [callback onHomeRequestSuccessWithName:data[@"name"]
                              appointments:[list consultas]
                                  thisWeek:@9];
    [[NSUserDefaults standardUserDefaults] setObject:data[@"name"] forKey:@"user-name"];
}

-(void)handleFailedResponse:(NSDictionary *)response callback:(id)callback
{
    [callback onHomeRequestFailure];
}

@end
