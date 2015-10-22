//
//  TextFieldWithoutCursor.m
//  Estetica Regenere
//
//  Created by Adriano on 10/22/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "TextFieldWithoutCursor.h"

@implementation TextFieldWithoutCursor

- (CGRect)caretRectForPosition:(UITextPosition *)position
{
    return CGRectZero;
}

@end
