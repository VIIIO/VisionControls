//
//  VisionSlideViewControllerDemo.m
//  VisionControls
//
//  Created by Vision on 16/3/16.
//  Copyright © 2016年 VIIIO. All rights reserved.
//

#import "VisionSlideViewControllerDemo.h"

@interface VisionSlideViewControllerDemo ()<VisionSlideViewControllerDataSource,VisionSlideViewControllerDelegate>
@property (strong,nonatomic) NSMutableArray *controllerArray;
@property (strong,nonatomic) NSMutableArray *controllerTitleArray;
@end

@implementation VisionSlideViewControllerDemo

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self visionSlideViewControllerSetUp];
}

- (void)visionSlideViewControllerSetUp{
    self.view.backgroundColor = [UIColor whiteColor];
    //demo settings
    self.delegate = self;
    self.dataSource = self;
    
    _controllerTitleArray = [@[@"First",@"Item",@"Product",@"Apple",@"Fruit",@"Color",@"Respect",@"ALongLongLongName"] mutableCopy];
    _controllerArray = [NSMutableArray array];
    for (NSInteger i = 1; i < 9; i++) {
        //add demo sub controllers
        Class cls_sub = NSClassFromString([NSString stringWithFormat:@"%@%ld",@"SlideSubController",(long)i]);
        id ctrl = [[cls_sub alloc] init];
        [_controllerArray addObject:ctrl];
    }
    self.titleViewNormalStateColor = [UIColor blackColor];
    self.titleViewFontSize = 16;
    self.titleViewWidth = 180;
    [self reloadData];
    //see VisionSlideViewController.h to get more methods & properties
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - dataSource & delegate
- (NSInteger)numberOfControllersInVisionSlider:(VisionSlideViewController *)slider{
    return self.controllerArray.count;
}

- (NSString *)visionSlider:(VisionSlideViewController *)slider titleForViewControllerAtIndex:(NSInteger)index{
    return self.controllerTitleArray[index];
}

- (UIViewController *)visionSlider:(VisionSlideViewController *)slider viewControllerAtIndex:(NSInteger)index{
    return self.controllerArray[index];
}

- (void)visionSlider:(VisionSlideViewController *)slider didEndDisplayingViewController:(UIViewController *)controller atIndex:(NSInteger)index{
    NSLog(@"Current controller:%@",self.controllerTitleArray[index]);
}
@end
