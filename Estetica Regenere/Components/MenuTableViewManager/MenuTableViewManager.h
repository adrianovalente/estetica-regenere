//
//  MenuTableViewManager.h
//  Estetica Regenere
//
//  Created by Adriano on 10/15/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "BaseTableViewManager.h"

@protocol MenuTableViewDelegate <NSObject>
-(void)didSelectMenuOption:(NSInteger)option;
@end

@interface MenuTableViewManager : BaseTableViewManager
@property (nonatomic) id<MenuTableViewDelegate> delegate;
@end
