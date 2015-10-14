//
//  BaseProvider.m
//  Estetica Regenere
//
//  Created by Adriano on 10/14/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "BaseProvider.h"
#import "AFHTTPRequestOperationManager.h"

@implementation BaseProvider

#pragma mark - abstract methods

-(void)handleSuccesfulResponse:(NSDictionary *)response callback:(id)callback
{
    
}

-(void)handleFailedResponse:(NSDictionary *)response callback:(id)callback
{
    
}

#pragma mark - methods to be inherited

-(void)performRequestWithPath:(NSString *)path
                      headers:(NSDictionary *)headers
                         data:(NSDictionary *)data
                       method:(NSString *)method
                     delegate:(id<BaseProviderCallback>)delegate
{
    
    NSURLRequest *request = [self buildRequestWithPath:path
                                               headers:headers
                                                  data:data
                                                method:method];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self verifyResponse:(NSDictionary *)responseObject delegate:delegate];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if ([[self noConnectionErrorCodes] containsObject:[NSNumber numberWithLongLong:error.code]]) {
            [delegate onNetworkFailure];
            return;
        }
        [self verifyResponse:(NSDictionary *)operation.responseObject delegate:delegate];
        
    }];
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    [operationQueue addOperation:operation];
}

#pragma mark - private methods
- (void) verifyResponse: (NSDictionary *)response
               delegate: (id<BaseProviderCallback>)delegate
{
    
    if ((!response) || ([response[@"isSuccess"] isEqual:[NSNull null]]) || ([response[@"content"] isEqual: [NSNull null]])) {
        [delegate onResponseFailure];
        return;
    }
    
    if([response[@"isSuccess"] isEqualToNumber:@1]) {
        [self handleSuccesfulResponse:response callback:delegate];
        return;
    }
    
    else {
        [self handleFailedResponse:response callback:delegate];
        return;
    }
    
}

- (NSURLRequest *) buildRequestWithPath:(NSString *)path
                                headers:(NSDictionary *)headers
                                   data:(NSDictionary *)data
                                 method:(NSString *)method
{
    
    NSString *fullPath = [@"http://127.0.0.1:8000" stringByAppendingString:path];
    AFJSONRequestSerializer *serializer = [[AFJSONRequestSerializer alloc] init];
    
    NSMutableURLRequest *request = [serializer requestWithMethod:method URLString:fullPath parameters:data error:nil];
    
    
    for (id key in headers) {
        [request addValue:(NSString *)headers[key] forHTTPHeaderField:(NSString *)key];
    }
    
    return request;
    
}

- (NSArray *) noConnectionErrorCodes
{
    
    // http://stackoverflow.com/questions/6778167/undocumented-nsurlerrordomain-error-codes-1001-1003-and-1004-using-storeki
    return @[
             @-998,
               @-999,
               @-1000,
               @-1001,
               @-1000,
               @-1001,
               @-1002,
               @-1003,
               @-1004,
               @-1005,
               @-1006,
               @-1007,
               @-1008,
               @-1009,
               @-1010
               ];
}


@end
