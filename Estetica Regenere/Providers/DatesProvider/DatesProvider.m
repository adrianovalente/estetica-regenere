//
//  DatesProvider.m
//  Estetica Regenere
//
//  Created by Adriano on 10/22/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "DatesProvider.h"

@implementation DatesProvider

- (NSString *)getStringToDate:(NSString *)date
{
    return [NSString stringWithFormat:@"%@ de %@", [[date componentsSeparatedByString:@"-"] objectAtIndex:0], [self getMonth:[[date componentsSeparatedByString:@"-"] objectAtIndex:1]]];
}
            
- (NSString *)getMonth:(NSString *)month
{
    return [@[
              @"",
              @"janeiro",
              @"fevereiro",
              @"março",
              @"abril",
              @"maio",
              @"junho",
              @"julho",
              @"agosto",
              @"setembro",
              @"outubro",
              @"novembro",
              @"dezembro"
              ] objectAtIndex:[month intValue]];
}

@end
