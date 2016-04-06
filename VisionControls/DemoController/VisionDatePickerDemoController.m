//
//  VisionDatePickerDemoController.m
//  VisionControls
//
//  Created by Vision on 16/3/15.
//  Copyright © 2016年 VIIIO. All rights reserved.
//

#import "VisionDatePickerDemoController.h"
#import "VisionDatePicker.h"

@interface VisionDatePickerDemoController ()
@property (strong,nonatomic) VisionDatePicker *picker;
@end

@implementation VisionDatePickerDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}

- (void)setUp{
    self.view.backgroundColor = [UIColor whiteColor];
    //demo textField
    UITextField *txt = [[UITextField alloc] initWithFrame:(CGRectMake(50, 100, 270, 40))];
    txt.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:txt];
    //add picker
    self.picker = [[VisionDatePicker alloc] initWithTextField:txt format:@"yyyy-MM-dd hh:mm:ss" dateDefault:[NSDate date] dateMode:(UIDatePickerModeDateAndTime) locale:[NSLocale currentLocale]];
    [self.picker setPlaceholder:@"Tap to choose"];
    [self.picker setPlaceholderWhileSelecting:@"请选择"];
    //see VisionDatePicker.h to get more methods & properties
    
    //properties
    NSArray *array = @[@"Change Format",@"Change Value",@"Change DateMode",@"Change Locale"];
    for (NSInteger i = 0; i < array.count; i++) {
        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        btn.frame = CGRectMake(50, 180 + i*40, 270, 30);
        btn.backgroundColor = [UIColor blueColor];
        [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [btn setTitle:array[i] forState:(UIControlStateNormal)];
        [self.view addSubview:btn];
        switch (i) {
            case 0:
                [btn addTarget:self action:@selector(btnChangeFormatTapped:) forControlEvents:(UIControlEventTouchUpInside)];
                break;
            case 1:
                [btn addTarget:self action:@selector(btnChangeValueTapped:) forControlEvents:(UIControlEventTouchUpInside)];
                break;
            case 2:
                [btn addTarget:self action:@selector(btnChangeDateModeTapped:) forControlEvents:(UIControlEventTouchUpInside)];
                break;
            case 3:
                [btn addTarget:self action:@selector(btnChangeLocaleTapped:) forControlEvents:(UIControlEventTouchUpInside)];
                break;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - changes
- (void)btnChangeFormatTapped:(id)sender{
    [self.picker setDateFormat:@"yyyy-MM-dd"];
}

- (void)btnChangeValueTapped:(id)sender{
    [self.picker setDate:[NSDate date]];
}

- (void)btnChangeDateModeTapped:(id)sender{
    [self.picker setDateMode:(UIDatePickerModeDate)];
}

- (void)btnChangeLocaleTapped:(id)sender{
    [self.picker setLocale:[NSLocale localeWithLocaleIdentifier:@"ja"]];
}

@end
