//
//  ServicesProvider.m
//  Estetica Regenere
//
//  Created by Adriano on 10/22/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "ServicesProvider.h"
#import "RegenereOption.h"

@implementation ServicesProvider

#pragma mark - public api
- (void)getServicesWithAreaId:(NSString *)areaId callback:(id<ServicesProviderCallback>)callback
{
    
    [self performRequestWithPath:[NSString stringWithFormat:@"/services/%@", areaId]
                         headers:@{}
                            data:@{}
                          method:@"GET"
                        callback:callback];
}

#pragma mark - abstract methods implementations
-(void)handleSuccesfulResponse:(NSDictionary *)response callback:(id)callback
{
    NSDictionary *data = [response objectForKey:@"content"];
    NSMutableArray *services = [NSMutableArray arrayWithObjects: nil];
    for (NSDictionary *dictionary in [data objectForKey:@"services"]) {
        NSError *err = nil;
        RegenereOption *option = [[RegenereOption alloc] initWithDictionary:dictionary error:&err];
        if (err == nil) {
            [services addObject:option];
        } else {
            [callback onResponseFailure];
            return;
        }
    }
    [callback onGetServicesSuccess:services];
}

-(void)handleFailedResponse:(NSDictionary *)response callback:(id)callback
{
    [callback onResponseFailure];
}


@end
