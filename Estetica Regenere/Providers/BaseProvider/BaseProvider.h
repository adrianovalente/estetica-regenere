//
//  BaseProvider.h
//  Estetica Regenere
//
//  Created by Adriano on 10/14/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BaseProviderCallback <NSObject>

-(void) onNetworkFailure;
-(void) onResponseFailure;

@end

@interface BaseProvider : NSObject

@end
