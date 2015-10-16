//
//  HomeTableViewCell.h
//  Estetica Regenere
//
//  Created by Adriano on 10/11/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeTableViewCellDelegate <NSObject>

-(void)didTapTrashIcon:(int)appointmentId;

@end

@interface HomeTableViewCell : UITableViewCell

@property (nonatomic) int appointmentId;
@property (nonatomic) id<HomeTableViewCellDelegate> trashDelegate;
- (void)fillCellWithName:(NSString *)name subtitle:(NSString *)subtitle time:(NSString *)time consultaId:(int)consultaId;

@end
