//
//  MenuTableViewCell.h
//  Estetica Regenere
//
//  Created by Adriano on 10/15/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuProvider.h"
@interface MenuTableViewCell : UITableViewCell

-(void)fillWithMenuOption:(MenuOption *)option;

@end
