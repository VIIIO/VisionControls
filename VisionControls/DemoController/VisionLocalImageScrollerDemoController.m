//
//  VisionLocalImageScrollerDemoController.m
//  VisionControls
//
//  Created by Vision on 16/3/16.
//  Copyright © 2016年 VIIIO. All rights reserved.
//

#import "VisionLocalImageScrollerDemoController.h"
#import "VisionLocalImageScroller.h"

@interface VisionLocalImageScrollerDemoController ()<VisionImageScrollerDelegate>{
    VisionLocalImageScroller *scroller;
}

@end

@implementation VisionLocalImageScrollerDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}

- (void)setUp{
    self.view.backgroundColor = [UIColor whiteColor];
    //local images
    NSMutableArray *imageArray = [NSMutableArray array];
    for (NSInteger i = 1; i < 6; i++) {
        [imageArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"VisionDemo-%ld.png",i]]];
    }
    //demo scroller.Autolayout is not supported yet.
    //如果該組件是ViewController下第一個子視圖，額外加一個UIView或禁用automaticallyAdjustsScrollViewInsets屬性否則內容會產生偏移.
    //Add a new UIView or set automaticallyAdjustsScrollViewInsets to NO if imageScroller would be the first child of viewController,otherwise contents in scroller will get an offset on Y axis
    [self.view addSubview:[UIView new]];//self.automaticallyAdjustsScrollViewInsets = NO;
    scroller = [[VisionLocalImageScroller alloc] initWithFrame:(CGRectMake(0, 100,[UIScreen mainScreen].bounds.size.width, 200))
                                                                              imageArray:imageArray
                                                                                autoPlay:YES];
    scroller.autoPlayInterval = 5;
    scroller.delegate = self;
    [self.view addSubview:scroller];
    //see VisionImageScroller.h to get more methods & properties
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - delegate
- (void)visionImageScroller:(VisionImageScroller *)scroller didSelectImageAtIndex:(NSInteger)index{
    NSLog(@"ScrollerImageClickedAtIndex:%ld",(long)index);
}

/** 屏幕旋轉時需要重置大小，重定義scroller.frame即可.  If your app support rotations,just reset scroller.frame */
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    scroller.frame = CGRectMake(0, 100,[UIScreen mainScreen].bounds.size.width, 200);
}
@end
