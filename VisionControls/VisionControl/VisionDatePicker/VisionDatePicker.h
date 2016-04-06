//
//  VisionDatePicker.h
//  VisionControls
//
//  Created by Vision on 16/3/15.
//  Copyright © 2016年 VIIIO. All rights reserved.
//

#import <UIKit/UIKit.h>
/* 注意：Picker必須聲明為全局變量或屬性，否則會自動回收
 */
@interface VisionDatePicker : UIControl<UITextFieldDelegate>
{
    UIDatePicker* pickerView;
    IBOutlet UITextField* textField;
    NSString* placeholder;
    NSString* placeholderWhileSelecting;
    NSString* toolbarDoneButtonText;
    NSString* toolbarClearButtonText;
    UIBarStyle toolbarStyle;
    NSLocale* dateLocal;
    NSString* dateFormat;
    NSDate* dateDefault;
    UIDatePickerMode dateMode;
}

@property (nonatomic, readonly) NSString* text;
@property (nonatomic) BOOL showClearButton;

- (id)initWithTextField:(UITextField *)tf format:(NSString *)format;
- (id)initWithTextField:(UITextField *)tf format:(NSString *)format dateDefault:(NSDate*)dt_default;
- (id)initWithTextField:(UITextField *)tf format:(NSString *)format dateDefault:(NSDate*)dt_default dateMode:(UIDatePickerMode)mode;
/**
 初始化picker
 @param tf 依附此文本框. the textField you want to change
 @param format 格式化文本，標準年月日格式yyyy-MM-dd hh:mm:ss. format of selected date
 @param dt_default 
 */
- (id)initWithTextField:(UITextField *)tf format:(NSString *)format dateDefault:(NSDate*)dt_default dateMode:(UIDatePickerMode)mode locale:(NSLocale *)locale;
- (void)setDate:(NSDate *)dt_default;
- (void)setDateFormat:(NSString *)format;
- (void)setLocale:(NSLocale *)locale;
- (void)setArrowImage:(UIImage*)image;
- (void)setDateMode:(UIDatePickerMode)mode;
- (void)setPlaceholder:(NSString*)str;
- (void)setPlaceholderWhileSelecting:(NSString*)str;
- (void)setToolbarDoneButtonText:(NSString*)str;
- (void)setToolbarClearButtonText:(NSString*)str;
- (void)setToolbarStyle:(UIBarStyle)style;
- (void)showArrowImage:(BOOL)b;
- (UIDatePicker*)getPickerView;
- (UITextField*)getTextField;
- (NSDate*)selectedDate;
/**
 格式化后的時間字符串
 */
- (NSString*)selectedDateString;
@end
