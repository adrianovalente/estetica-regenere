//
//  LoginProvider.m
//  Estetica Regenere
//
//  Created by Adriano on 10/14/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "LoginProvider.h"
#import "AFHTTPRequestOperationManager.h"

@implementation LoginProvider

-(void)performLoginWithEmail:(NSString *)email
                     passord:(NSString *)password
                    delegate:(id<LoginProviderDelegate>)delegate
{
    NSDictionary*params = @{
                          @"email":email,
                          @"password":password
                          };

    NSURLRequest *request = [self buildRequestWithPath:@"/login/"
                                               headers:@{}
                                                  data:params
                                                method:@"POST"];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self handleResponse:(NSDictionary *)responseObject delegate:delegate];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if ([[self noConnectionErrorCodes] containsObject:[NSNumber numberWithLongLong:error.code]]) {
            [delegate onNetworkFailure];
            return;
        }
        
        
        [self handleResponse:(NSDictionary *)operation.responseObject delegate:delegate];
        
    }];
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    [operationQueue addOperation:operation];
}

#pragma mark - private methods
- (void) handleResponse: (NSDictionary *)response
               delegate: (id<LoginProviderDelegate>)delegate
{
    
    if ((!response) || ([response[@"isSuccess"] isEqual:[NSNull null]]) || ([response[@"content"] isEqual: [NSNull null]])) {
        [delegate onResponseFailure];
        return;
    }
    
    if([response[@"isSuccess"] isEqualToNumber:@1]) {
        [delegate onLoginSuccessWithToken:@"ASHUASHUAHSUAHUS"];
        return;
    }
    
    else {
        [delegate onLoginFailure];
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