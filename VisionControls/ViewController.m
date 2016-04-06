//
//  ViewController.m
//  VisionControls
//
//  Created by VIIIO on 16/3/15.
//  Copyright © 2016年 VIIIO. All rights reserved.
//

#import "ViewController.h"
#import "VisionCaptureControl.h"
#import "VisionDatePickerDemoController.h"
#import "VisionPickerDemoController.h"
#import "VisionRemoteImageScrollerDemoController.h"
#import "VisionLocalImageScrollerDemoController.h"
#import "VisionSinglePhotoPicker.h"
#import "VisionSlideSegmentViewDemoController.h"
#import "VisionSlideViewControllerDemo.h"

#import "CommonSearchController.h"
#import "CommonSimpleDetailController.h"
#import "CommonWebController.h"

@interface ViewController ()<VisionSinglePhotoPickerDelegate,CommonSearchControllerDelegate>

@property (strong,nonatomic) NSArray *titleArray;
@property (strong,nonatomic) UIImage *pickedImage;
@property (copy,nonatomic) NSString *pickedString;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
}

- (void)initData{
    self.title = @"VisionControls";
    _titleArray = @[@"VisionCaptureControl",
                    @"VisionPicker",
                    @"VisionDatePicker",
                    @"VisionRemoteImageScroller",//require SDWebImage
                    @"VisionLocalImageScroller",
//                    @"VisionImageSwiper",//require 2 different compotents so I removed it
                    @"VisionSinglePhotoPicker",
//                    @"VisionMultiplePhotoPicker",//rely on third-party imagePicker so I removed it
                    @"VisionSlideSegmentView",
                    @"VisionSlideViewController",
                    @"CommonSearchController",
                    @"CommonSimpleDetailController",
                    @"CommonWebController"];
    self.pickedString = @"grape";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - tableView Delegate &DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *st_cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:st_cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:st_cellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSString *title = self.titleArray[indexPath.row];
    cell.textLabel.text = title;
    //Special setting on SinglePhotoPicker
    if ([title isEqualToString:@"VisionSinglePhotoPicker"] && self.pickedImage) {
        cell.imageView.image = self.pickedImage;
    }else{
        cell.imageView.image = nil;
    }
    //Special setting on CommonSearchController
    if ([title isEqualToString:@"CommonSearchController"] && self.pickedString){
        cell.detailTextLabel.text = self.pickedString;
    }else{
        cell.detailTextLabel.text = nil;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *ctrl;
    Class cls_ctrl;
    switch (indexPath.row) {
        case 0://VisionCaptureControl
        {
            if (TARGET_IPHONE_SIMULATOR) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Capture control can't run on simulator.此控件必须在真机上调试。" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }else{
                VisionCaptureControl *capture = [[VisionCaptureControl alloc] init];
                [capture setMultiMode:NO];
                [capture setCallback:^(NSString *result) {
                    NSLog(@"已識別：%@",result);
                }];
                [capture show];
            }
            return;
        }
            break;
        case 1:
            cls_ctrl = [VisionPickerDemoController class];
            break;
        case 2:
            cls_ctrl = [VisionDatePickerDemoController class];
            break;
        case 3:
            cls_ctrl = [VisionRemoteImageScrollerDemoController class];
            break;
        case 4:
            cls_ctrl = [VisionLocalImageScrollerDemoController class];
            break;
        case 5:{//VisionSinglePhotoPicker
            VisionSinglePhotoPicker *picker = [[VisionSinglePhotoPicker alloc] initWithTarget:self];
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {//判斷是不是Pad
                //是Pad必須指定sourceView
                [picker setPadPopoverSourceView:[tableView cellForRowAtIndexPath:indexPath]];
            }
            [picker show];
            return;
        }
            break;
        case 6:
            cls_ctrl = [VisionSlideSegmentViewDemoController class];
            break;
        case 7:
            cls_ctrl = [VisionSlideViewControllerDemo class];
            break;
        case 8://CommonSearchController
        {
            CommonSearchController *ctrl_search = [[CommonSearchController alloc] init];
            ctrl_search.delegate = self;
            [ctrl_search initDataSource:[@[[CboDataMODEL modelWithValue:@"apple" name:@"LongNameForApple"],
                                           [CboDataMODEL modelWithValue:@"banana" name:@"LongNameForBanana"],
                                           [CboDataMODEL modelWithValue:@"grape" name:@"LongNameForGrape"],
                                           [CboDataMODEL modelWithValue:@"watermelon" name:@"LongNameForWatermelon"],
                                           [CboDataMODEL modelWithValue:@"pear" name:@"LongNameForPear"],
                                           ]
                                        mutableCopy]
                           withSelected:self.pickedString
                                userTag:nil];//pass anything you want to modify after selecting
            ctrl = ctrl_search;
        }
            break;
        case 9://CommonSimpleDetailController
        {
            CommonSimpleDetailController *ctrl_detail = [[CommonSimpleDetailController alloc] init];
            ctrl_detail.detailText = @"This is a very very very very very very very long text that you couldn't show it all in your UILabel or UITableViewCell or anything else so CommonSimpleDetailController provides a simple individual controller to show it.Support rotations.";
            ctrl = ctrl_detail;
        }
            break;
        case 10://CommonWebController
        {
            CommonWebController *ctrl_web = [[CommonWebController alloc] init];
            ctrl_web.url = @"https://www.baidu.com/";
            ctrl_web.showContentLoadingIndicator = YES;//default is YES
            ctrl = ctrl_web;
        }
            break;
    }
    if (cls_ctrl) {
        ctrl = [[cls_ctrl alloc] init];
        ctrl.title = self.titleArray[indexPath.row];
        [self pushTo:ctrl];
    }else if (ctrl){
        ctrl.title = self.titleArray[indexPath.row];
        [self pushTo:ctrl];
    }
}

- (void)pushTo:(UIViewController *)ctrl{
    [self.navigationController pushViewController:ctrl animated:YES];
}

#pragma mark - visionControl delegates
#pragma mark visionSinglePhotoPickerDelegate
- (void)visionSinglePhotoPicker:(VisionSinglePhotoPicker *)picker pickedImage:(UIImage *)image{
    self.pickedImage = image;
    [self.tableView reloadData];
}

#pragma mark commonSearchControllerDelegate
- (void)commonSearchController:(CommonSearchController *)controller singleItemSelected:(CboDataMODEL *)model userTag:(id)userTag{
    self.pickedString = model.value;
    [self.tableView reloadData];
}
@end
