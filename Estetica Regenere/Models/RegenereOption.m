//
//  RegenereOption.m
//  Estetica Regenere
//
//  Created by Adriano on 10/22/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "RegenereOption.h"

@implementation RegenereOption

+ (RegenereOption *)optionWithValue:(NSString *)value
                               name:(NSString *)name
{
    NSDictionary *dic = @{
                          @"name": name,
                          @"id": value
                          };
    return [[RegenereOption alloc] initWithDictionary:dic
                                                error:nil];
    
}


+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"name" : @"name",
                                                       @"id"   : @"optionId"
                                                       }];
}

@end
