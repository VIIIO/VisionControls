//
//  VisionPickerDemoController.m
//  VisionControls
//
//  Created by Vision on 16/3/15.
//  Copyright © 2016年 VIIIO. All rights reserved.
//

#import "VisionPickerDemoController.h"
#import "VisionPicker.h"

@interface VisionPickerDemoController ()<VisionPickerDelegate>
@property (strong,nonatomic) UILabel *valueLabel;
@end

@implementation VisionPickerDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}

- (void)setUp{
    self.view.backgroundColor = [UIColor whiteColor];
    //demo picker
    VisionPicker *picker = [[VisionPicker alloc] initWithFrame:CGRectMake(50, 100, 270, 40)
                                                          data:[@[[CboDataMODEL modelWithValue:@"ValueA" name:@"First Object"],
                                                                 [CboDataMODEL modelWithValue:@"ValueB" name:@"2nd Object"],
                                                                 [CboDataMODEL modelWithValue:@"ValueC" name:@"3nd Object"],
                                                                 [CboDataMODEL modelWithValue:@"ValueD" name:@"4th Object"],
                                                                 [CboDataMODEL modelWithValue:@"ValueE" name:@"5th Object"],
                                                                 ] mutableCopy]];
    picker.delegate = self;
    [self.view addSubview:picker];
    //see VisionPicker.h to get more methods & properties
    
    //value presentation
    _valueLabel = [[UILabel alloc] initWithFrame:(CGRectMake(50, 180, 270, 20))];
    [self.view addSubview:_valueLabel];
}

#pragma mark - delegate
- (void)visionPicker:(VisionPicker *)picker selectedItem:(CboDataMODEL *)item index:(NSInteger)index{
    NSLog(@"SelectedValue:%@ - Name %@ - Index:%zi",item.value,item.name,index);
    self.valueLabel.text = [NSString stringWithFormat:@"SelectedValue: %@",item.value];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
