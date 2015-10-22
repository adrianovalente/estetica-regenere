//
//  AreasProvider.m
//  Estetica Regenere
//
//  Created by Adriano on 10/22/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "AreasProvider.h"
#import "RegenereOption.h"

@implementation AreasProvider

#pragma mark - public api
- (void)getAreasWithCallback:(id<AreasProviderCallback>)callback
{
        
        [self performRequestWithPath:@"/areas"
                             headers:@{}
                                data:@{}
                              method:@"GET"
                            callback:callback];
}

#pragma mark - abstract methods implementations
-(void)handleSuccesfulResponse:(NSDictionary *)response callback:(id)callback
{
    NSDictionary *data = [response objectForKey:@"content"];
    NSMutableArray *areas = [NSMutableArray arrayWithObjects: nil];
    for (NSDictionary *dictionary in [data objectForKey:@"areas"]) {
        NSError *err = nil;
        RegenereOption *option = [[RegenereOption alloc] initWithDictionary:dictionary error:&err];
        if (err == nil) {
            [areas addObject:option];
        } else {
            [callback onResponseFailure];
            return;
        }
    }
    [callback onGetAreasSuccess:areas];
}

-(void)handleFailedResponse:(NSDictionary *)response callback:(id)callback
{
    [callback onResponseFailure];
}



@end
