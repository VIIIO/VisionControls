//
//  VisionSlideViewController.h
//  VisionControls
//
//  Created by Vision on 16/3/17.
//  Copyright © 2016年 VIIIO. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VisionSlideViewController;
@protocol VisionSlideViewControllerDelegate <NSObject>
@optional
- (void)visionSlider:(VisionSlideViewController *)slider didEndDisplayingViewController:(UIViewController *)controller atIndex:(NSInteger)index;
@end

@protocol VisionSlideViewControllerDataSource <NSObject>
@required
- (NSInteger)numberOfControllersInVisionSlider:(VisionSlideViewController *)slider;
- (UIViewController *)visionSlider:(VisionSlideViewController *)slider viewControllerAtIndex:(NSInteger)index;

@optional
- (NSString *)visionSlider:(VisionSlideViewController *)slider titleForViewControllerAtIndex:(NSInteger)index;
@end

@interface VisionSlideViewController : UIViewController<UIPageViewControllerDataSource,UIPageViewControllerDelegate>
@property (weak,nonatomic) id<VisionSlideViewControllerDelegate> delegate;
@property (weak,nonatomic) id<VisionSlideViewControllerDataSource> dataSource;

/*navigationbar titleView相關設定*/
/**titleView寬度*/
@property (assign,nonatomic) CGFloat titleViewWidth;
/**正常色*/
@property (strong,nonatomic) UIColor *titleViewNormalStateColor;
/**選中色*/
@property (strong,nonatomic) UIColor *titleViewSelectedStateColor;
/**字體大小，默認systemFontSize*/
@property (assign,nonatomic) CGFloat titleViewFontSize;
/**下劃線高度，默認2*/
@property (assign,nonatomic) CGFloat titleViewBottomLineHeight;
/*方法*/
- (void)reloadData;
- (void)moveToViewControllerAtIndex:(NSInteger)index;
- (UIViewController *)viewControllerAtIndex:(NSInteger)index;
@end