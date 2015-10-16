//
//  MenuProvider.h
//  Estetica Regenere
//
//  Created by Adriano on 10/15/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MenuOption : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSString *selectedImageName;

@end

@interface MenuProvider : NSObject
-(NSArray *)getMenuOptions;
@end
