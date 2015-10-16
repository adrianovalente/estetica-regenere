//
//  DeleteAppointmentProvider.h
//  Estetica Regenere
//
//  Created by Adriano on 10/16/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "BaseProvider.h"

@protocol DeleteAppointmentCallback <BaseProviderCallback>

-(void)onDeleteAppointmentSuccess;
-(void)onTokenMissing;
-(void)onDeleteAppointmentFailure;

@end

@interface DeleteAppointmentProvider : BaseProvider

-(void)deleteAppointmentWithId:(int)appointmentId callback:(id<DeleteAppointmentCallback>)callback;

@end
