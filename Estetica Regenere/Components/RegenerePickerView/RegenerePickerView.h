//
//  RegenerePickerView.h
//  Estetica Regenere
//
//  Created by Adriano on 10/22/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "BaseComponentsView.h"

@protocol RegenerePickerViewDelegate <NSObject>

-(void)regenerePickerView:(id)pickerView didChangeToValue:(NSString *)value;

@end


@interface RegenerePickerView : BaseComponentsView

-(void)setPlaceholder:(NSString *)placeholder;
-(void)updateWithOptions:(NSArray *)options;
-(NSString *)getSelectedOptionValue;

@property (nonatomic) id<RegenerePickerViewDelegate> delegate;

@end
