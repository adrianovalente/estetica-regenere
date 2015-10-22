//
//  RegenerePickerView.m
//  Estetica Regenere
//
//  Created by Adriano on 10/22/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "RegenerePickerView.h"
#import "RegenereOption.h"

@interface RegenerePickerView () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *bckView;
@property (weak, nonatomic) IBOutlet UITextField *txtField;
@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) NSArray *options;

@end

@implementation RegenerePickerView

#pragma mark - public api
-(void)setPlaceholder:(NSString *)placeholder
{
    [self.txtField setText:placeholder];
}

-(void)updateWithOptions:(NSArray *)options
{
    self.options = options;
    [self.pickerView reloadAllComponents];
}

-(NSString *)getSelectedOptionValue
{
    return [NSString stringWithFormat:@"%@", [(RegenereOption *)[self.options objectAtIndex:[self.pickerView selectedRowInComponent:0]] optionId]];
}


#pragma mark - setup methods
-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setupBorders];
    [self setupTextField];
}

-(void)setupTextField
{

    [self.txtField setInputView:self.pickerView];
}

-(void)setupBorders
{
    self.bckView.layer.cornerRadius = 15;
    self.bckView.layer.masksToBounds = YES;
    self.bckView.layer.borderColor = [[UIColor colorWithRed:(61/255.0) green:(145/255.0) blue:(107/255.0) alpha:1] CGColor];
    self.bckView.layer.borderWidth = 1.0f;
}

#pragma mark - Picker View Data Source and Delegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.options count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [(RegenereOption *)[self.options objectAtIndex:row] name];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    [self.txtField setText:[(RegenereOption *)[self.options objectAtIndex:row] name]];
    [self.txtField endEditing:NO];
    [self.delegate regenerePickerView:self didChangeToValue:[(RegenereOption *)[self.options objectAtIndex:row] name]];
}



#pragma mark - Picker View Lazy Instantiation
-(UIPickerView *)pickerView
{
    if (!_pickerView) _pickerView = [UIPickerView new];
    [_pickerView setDelegate:self];
    [_pickerView setDataSource:self];
    [_pickerView setBackgroundColor:[UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1.0]];
    return _pickerView;
}

@end


