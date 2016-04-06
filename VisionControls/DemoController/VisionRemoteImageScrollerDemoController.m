//
//  VisionRemoteImageScrollerDemoController.m
//  VisionControls
//
//  Created by Vision on 16/3/16.
//  Copyright © 2016年 VIIIO. All rights reserved.
//

#import "VisionRemoteImageScrollerDemoController.h"
#import "VisionRemoteImageScroller.h"

@interface VisionRemoteImageScrollerDemoController ()<VisionImageScrollerDelegate>{
    VisionRemoteImageScroller *scroller;
}

@end

@implementation VisionRemoteImageScrollerDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}

- (void)setUp{
    self.view.backgroundColor = [UIColor whiteColor];
    //demo scroller.Autolayout is not supported yet.
    //如果該組件是ViewController下第一個子視圖，額外加一個UIView或禁用automaticallyAdjustsScrollViewInsets屬性否則內容會產生偏移.
    //Add a new UIView or set automaticallyAdjustsScrollViewInsets to NO if imageScroller would be the first child of viewController,otherwise contents in scroller will get an offset on Y axis
    [self.view addSubview:[UIView new]];//self.automaticallyAdjustsScrollViewInsets = NO;
    scroller = [[VisionRemoteImageScroller alloc] initWithFrame:(CGRectMake(0, 100,[UIScreen mainScreen].bounds.size.width, 200))
                                                                              imageArray:@[@"https://m.360buyimg.com/mobilecms/s1242x679_jfs/t2419/337/2585382923/114642/d405e149/56e7c74fNb00f1b24.jpg!q70.jpg",
                                                                                           @"http://m.360buyimg.com/mobilecms/s1242x679_jfs/t2260/227/2667825062/89902/1888fd11/56e81391N7ad853b8.jpg!q70.jpg",
                                                                                           @"http://m.360buyimg.com/mobilecms/s1242x679_jfs/t2107/319/1964560602/144874/5af668dc/56e7ac8aNba2a03c0.jpg!q70.jpg",
                                                                                           @"http://m.360buyimg.com/mobilecms/s1242x679_jfs/t2329/55/2631668031/477931/c85f6267/56e7a8f5N338bec7b.jpg!q70.jpg",
                                                                                           @"http://m.360buyimg.com/mobilecms/s1242x679_jfs/t2479/42/1992251861/144007/8eff6459/56e7ac60Nd60ba899.jpg!q70.jpg",
                                                                                           @"http://m.360buyimg.com/mobilecms/s1242x427_jfs/t2395/35/1907408534/154899/ba1263ce/56e82bedN5c7b4818.jpg!q70.jpg",
                                                                                           @"http://m.360buyimg.com/mobilecms/s1242x679_jfs/t1840/84/2595840497/141384/2e5b6eef/56e7dd1bNcaf0ff72.jpg!q70.jpg",
                                                                                           ]
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
