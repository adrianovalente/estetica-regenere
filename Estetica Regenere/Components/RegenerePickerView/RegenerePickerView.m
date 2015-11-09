//
//  RegenerePickerView.m
//  Estetica Regenere
//
//  Created by Adriano on 10/22/15.
//  Copyright (c) 2015 Adriano. All rights reserved.
//

#import "RegenerePickerView.h"
#import "RegenereOption.h"

@interface RegenerePickerView () <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *bckView;
@property (weak, nonatomic) IBOutlet UITextField *txtField;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImg;
@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) NSArray *options;
@property (strong, nonatomic) NSString *placeholderString;

@end

@implementation RegenerePickerView {
    RegenerePickerViewStatus _currentStatus;
    NSString *_currentValue;
}

#pragma mark - public api
-(void)setPlaceholder:(NSString *)placeholder
{
    [self.txtField setText:placeholder];
    self.placeholderString = placeholder;
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

- (void)showPlaceHoderInsteadOfSelectedValue:(BOOL)showPlacehoder
{
    if (showPlacehoder) {
        [self.txtField setText:self.placeholderString];
    } else {
        [self.txtField setText:[(RegenereOption *)[self.options objectAtIndex:[self.pickerView selectedRowInComponent:0]] name]];
    }
}

- (void)setStatus:(RegenerePickerViewStatus)status
{
    if (status == RegenerePickerViewStatusNormal) {
        [self.txtField setEnabled:YES];
        [self.bckView.layer setBorderColor: [[UIColor colorWithRed:(61/255.0) green:(145/255.0) blue:(107/255.0) alpha:1] CGColor]];
        [self.arrowImg setHidden:NO];
        _currentStatus = RegenerePickerViewStatusNormal;
        return;
    }
    
    if (status == regenerePickerViewStatusDisabled) {
        [self.txtField setEnabled:NO];
        [self.bckView.layer setBorderColor: [[UIColor colorWithRed:(142/255.0) green:(142/255.0) blue:(147/255.0) alpha:1] CGColor]];
        [self.arrowImg setHidden:YES];
        _currentStatus = regenerePickerViewStatusDisabled;
    }
}

-(void)endEditing
{
    [self.txtField endEditing:NO];
}

#pragma mark - setup methods
-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setupBorders];
    [self setupTextField];
    [self setStatus:RegenerePickerViewStatusNormal];
}

-(void)setupTextField
{
    [self.txtField setInputView:self.pickerView];
    [self.txtField setDelegate:self];
}

-(void)setupBorders
{
    self.bckView.layer.cornerRadius = 15;
    self.bckView.layer.masksToBounds = YES;
    self.bckView.layer.borderWidth = 1.0f;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.delegate regenerePickerView:self didChangeToValue:_currentValue];
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
    _currentValue = [(RegenereOption *)[self.options objectAtIndex:row] name];
    
}



#pragma mark - Lazy Instantiations
-(UIPickerView *)pickerView
{
    if (!_pickerView) _pickerView = [UIPickerView new];
    [_pickerView setDelegate:self];
    [_pickerView setDataSource:self];
    [_pickerView setBackgroundColor:[UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1.0]];
    return _pickerView;
}

-(NSString *)placeholderString
{
    if (!_placeholderString) _placeholderString = @"Escolha";
    return _placeholderString;
}

@end