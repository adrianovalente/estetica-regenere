//
//  RegenereOption.m
//  Estetica Regenere
//
//  Created by Adriano on 10/22/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "RegenereOption.h"

@implementation RegenereOption

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"name" : @"name",
                                                       @"id"   : @"optionId"
                                                       }];
}

@end
