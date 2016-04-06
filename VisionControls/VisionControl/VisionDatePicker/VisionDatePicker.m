//
//  VisionDatePicker.m
//  VisionControls
//
//  Created by Vision on 16/3/15.
//  Copyright © 2016年 VIIIO. All rights reserved.
//

#import "VisionDatePicker.h"

@implementation VisionDatePicker
- (id)initWithTextField:(UITextField *)tf format:(NSString *)format
{
    return [self initWithTextField:tf format:format dateDefault:[NSDate date]];
}
- (id)initWithTextField:(UITextField *)tf format:(NSString *)format dateDefault:(NSDate*) dt_default{
    return [self initWithTextField:tf format:format dateDefault:dt_default dateMode:UIDatePickerModeDate];
}
- (id)initWithTextField:(UITextField *)tf format:(NSString *)format dateDefault:(NSDate*) dt_default dateMode:(UIDatePickerMode)mode{
    return [self initWithTextField:tf format:format dateDefault:dt_default dateMode:mode locale:[NSLocale currentLocale]];
}
- (id)initWithTextField:(UITextField *)tf format:(NSString *)format dateDefault:(NSDate*) dt_default dateMode:(UIDatePickerMode)mode locale:(NSLocale *)locale{
    self = [super init];
    if (self) {
        self->textField = tf;
        self->textField.delegate = self;
        
        // set UI defaults
        self->toolbarStyle = UIBarStyleDefault;
        
        // set language defaults
        self->placeholder = @"请选择";
        self->placeholderWhileSelecting = @"请选择";
        self->toolbarDoneButtonText = @"完成";
        self->toolbarClearButtonText = @"清空";
        
        // hide the caret and its blinking
        [[textField valueForKey:@"textInputTraits"]
         setValue:[UIColor clearColor]
         forKey:@"insertionPointColor"];
        
        // set the placeholder
        self->textField.placeholder = self->placeholder;
        
        // show the arrow image
        self->textField.rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"VisionPickerDownArrow.png"]];
        self->textField.rightView.contentMode = UIViewContentModeScaleAspectFit;
        self->textField.rightView.clipsToBounds = YES;
        [self setArrowImage:[UIImage imageNamed:@"VisionPickerDownArrow.png"]];
        [self showArrowImage:YES];
        
        if (locale != nil) {
            [self setLocale:nil];
        }
        if (format) {
            [self setDateFormat:format];
        }else{
            [self setDateFormat:@"yyyy-MM-dd"];
        }
        if (mode) {
            [self setDateMode:mode];
        }else{
            [self setDateMode:UIDatePickerModeDate];
        }
        if (dt_default != nil) {
            [self setDate:dt_default];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:self->dateFormat];
            self->textField.text = [dateFormatter stringFromDate:dt_default];
        }
    }
    return self;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)doneClicked:(id) sender
{
    [textField resignFirstResponder]; //hides the pickerView
    //可以在此方法處理反序列化
    self->textField.text = [self selectedDateString];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)clearClicked:(id) sender
{
    textField.text = nil;
    [textField resignFirstResponder]; //hides the pickerView
    //可以在此方法處理反序列化
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)aTextField
{
    [self showPicker:aTextField];
    return YES;
}

- (IBAction)showPicker:(id)sender
{
    pickerView = [[UIDatePicker alloc] init];
    [pickerView setLocale:self->dateLocal];
    [pickerView setDatePickerMode:self->dateMode];
    //If the text field is empty show the place holder otherwise show the last selected option
    if (self->textField.text.length == 0)
    {
        self->textField.placeholder = self->placeholderWhileSelecting;
    }
    else
    {
        //反序列化為NSDate再選中
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:self->dateFormat];
        NSDate *dt_selected = [dateFormatter dateFromString:self->textField.text];
        [self->pickerView setDate:dt_selected animated:NO];
    }
    
    UIToolbar* toolbar = [[UIToolbar alloc] init];
    toolbar.barStyle = self->toolbarStyle;
    [toolbar sizeToFit];
    
    //to make the done button aligned to the right
    UIBarButtonItem* clearButton = [[UIBarButtonItem alloc]
                                    initWithTitle:self->toolbarClearButtonText
                                    style:UIBarButtonItemStyleDone
                                    target:self
                                    action:@selector(clearClicked:)];
    
    UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc]
                                   initWithTitle:self->toolbarDoneButtonText
                                   style:UIBarButtonItemStyleDone
                                   target:self
                                   action:@selector(doneClicked:)];
    
    if (self.showClearButton) {
        [toolbar setItems:[NSArray arrayWithObjects:clearButton, flexibleSpaceLeft, doneButton, nil]];
    }else{
        [toolbar setItems:[NSArray arrayWithObjects:flexibleSpaceLeft, doneButton, nil]];
    }
    
    //custom input view
    textField.inputView = pickerView;
    textField.inputAccessoryView = toolbar;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return NO;
}

- (void)showArrowImage:(BOOL)b
{
    if (b == YES) {
        // set the DownPicker arrow to the right (you can replace it with any 32x24 px transparent image: changing size might give different results)
        self->textField.rightViewMode = UITextFieldViewModeAlways;
    }
    else {
        self->textField.rightViewMode = UITextFieldViewModeNever;
    }
}

- (void)setArrowImage:(UIImage*)image
{
    [(UIImageView*)self->textField.rightView setImage:image];
}

- (void)setPlaceholder:(NSString*)str
{
    self->placeholder = str;
    self->textField.placeholder = self->placeholder;
}

- (void)setPlaceholderWhileSelecting:(NSString*)str
{
    self->placeholderWhileSelecting = str;
}

- (void)setToolbarDoneButtonText:(NSString*)str
{
    self->toolbarDoneButtonText = str;
}

- (void)setToolbarStyle:(UIBarStyle)style;
{
    self->toolbarStyle = style;
}
- (void) setToolbarClearButtonText:(NSString*)str{
    self->toolbarClearButtonText = str;
}

- (void)setDate:(NSDate *)dt_default{
    if (dt_default) {
        self->dateDefault = dt_default;
        [self setDateText:dt_default];
        if (self->pickerView) {
            [self->pickerView setDate:dt_default animated:YES];
        }
    }
}
- (void)setDateFormat:(NSString *)format{
    if (format) {
        self->dateFormat = format;
        if (self->pickerView) {
            textField.text = [self selectedDateString];
        }else if (self->textField.text.length >0) {
            [self setDateText:self->dateDefault];
        }
    }
}
- (void)setLocale:(NSLocale *)locale{
    if (locale) {
        self->dateLocal = locale;
    }else{
        self->dateLocal = [NSLocale currentLocale];
    }
}
- (void)setDateMode:(UIDatePickerMode) mode{
    self->dateMode = mode;
}

- (UIDatePicker*)getPickerView
{
    return self->pickerView;
}

- (UITextField*)getTextField
{
    return self->textField;
}
- (NSDate*)selectedDate{
    return self->pickerView.date;
}
/**
 格式化后的時間字符串
 */
- (NSString*)selectedDateString{
    NSDate *selected = [self->pickerView date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:self->dateFormat];
    return [dateFormatter stringFromDate:selected];
}

- (void)setDateText:(NSDate *)date{
    NSDate *selected = date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:self->dateFormat];
    self->textField.text = [dateFormatter stringFromDate:selected];
}

//Getter method for self.text
- (NSString*)text {
    return self->textField.text;
}

@end
