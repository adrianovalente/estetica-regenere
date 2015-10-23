//
//  RegenerePickerView.h
//  Estetica Regenere
//
//  Created by Adriano on 10/22/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "BaseComponentsView.h"

typedef enum RegenerePickerViewStatus : int {
    RegenerePickerViewStatusNormal,
    regenerePickerViewStatusDisabled
} RegenerePickerViewStatus;

@protocol RegenerePickerViewDelegate <NSObject>

-(void)regenerePickerView:(id)pickerView didChangeToValue:(NSString *)value;

@end


@interface RegenerePickerView : BaseComponentsView

-(void)setPlaceholder:(NSString *)placeholder;
-(void)updateWithOptions:(NSArray *)options;
-(NSString *)getSelectedOptionValue;
-(void)setStatus:(RegenerePickerViewStatus)status;
-(void)showPlaceHoderInsteadOfSelectedValue:(BOOL)showPlacehoder;

@property (nonatomic) id<RegenerePickerViewDelegate> delegate;

@end
