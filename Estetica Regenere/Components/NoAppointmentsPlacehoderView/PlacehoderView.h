//
//  NoAppointmentsPlacehoderView.h
//  Estetica Regenere
//
//  Created by Adriano on 10/24/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "BaseComponentsView.h"

@protocol PlaceholderDelegate <NSObject>

-(void)scheduleAppointmentButtonPressed;
-(void)tryAgainButtonPressed;

@end

@interface PlacehoderView : BaseComponentsView

@property (nonatomic) id<PlaceholderDelegate>delegate;
-(void)showNoConnectionPlaceHolder;
-(void)showNoAppointmentsPlaceholder;
-(void)hide;

@end
