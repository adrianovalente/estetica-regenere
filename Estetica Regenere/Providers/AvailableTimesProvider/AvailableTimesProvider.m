//
//  AvailableTimesProvider.m
//  Estetica Regenere
//
//  Created by Adriano on 10/22/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "AvailableTimesProvider.h"
#import "RegenereOption.h"
#import "DatesProvider.h"

@interface AvailableTimesProvider ()
@property (strong, nonatomic) NSMutableArray *dateOptionsArray;
@property (strong, nonatomic) NSMutableDictionary *timeOptionsDictionary;
@end

@implementation AvailableTimesProvider

#pragma mark - public api
- (void)getAbailableTimesToService:(NSString *)service
                          callback:(id<AvailableTimesProviderCallback>)callback
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"user-token"];
    if (token != nil && ![token isEqual:[NSNull null]]) {
        NSDictionary *authHeaders = @{
                                      @"regeneretoken": token
                                      };
        
        [self performRequestWithPath:[NSString stringWithFormat:@"/times/%@", service]
                             headers:authHeaders
                                data:@{}
                              method:@"GET"
                            callback:callback];
    } else {
        [callback onTokenMissing];
    }
}

- (NSArray *)getDates
{
    return self.dateOptionsArray;
}

- (NSArray *)getTimesToDate:(NSString *)date
{
    return [self.timeOptionsDictionary objectForKey:date];
}

#pragma mark - abstract methods implementations
-(void)handleSuccesfulResponse:(NSDictionary *)response callback:(id)callback
{
    // initing properties
    self.dateOptionsArray = [NSMutableArray arrayWithObjects: nil];
    self.timeOptionsDictionary = [NSMutableDictionary dictionary];
    
    // making sure answer is as it's supposed to be
    NSDictionary *dates = [[response objectForKey:@"contents"] objectForKey:@"dates"];
    if (dates == nil) {
        return [callback onResponseFailure];
    }
    
    // making sure there's a 'date' key
    for (NSDictionary *dictionary in dates) {
        NSString *dateString = [dictionary objectForKey:@"date"];
        if (dateString == nil) {
            return [callback onResponseFailure];
        }
        
        // adding date to array
        [self.dateOptionsArray addObject:[RegenereOption optionWithValue:dateString name:[[DatesProvider new] getStringToDate:dateString]]];
        
        // making sure we have a 'times' key
        NSArray *timesArray = [dictionary objectForKey:@"times"];
        if (timesArray == nil) {
            return [callback onResponseFailure];
        }
        
        // adding key to dic
        [self.timeOptionsDictionary setObject:[NSMutableArray arrayWithObjects:nil] forKey:dateString];
        
        for (NSString *time in timesArray) {
            // adding time to array
            [(NSMutableArray *)[self.timeOptionsDictionary objectForKey:dateString] addObject:[RegenereOption optionWithValue:time name:time]];
        }
        
    }
    
    NSLog(@"MDS como deu certo isso?");
    [callback onGetAvailableTimesSuccess];

}

-(void)handleFailedResponse:(NSDictionary *)response callback:(id)callback
{
    [callback onResponseFailure];
}


@end
