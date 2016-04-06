//
//  VisionImageScroller.h
//  VisionControls
//
//  Created by Vision on 16/3/15.
//  Copyright © 2016年 VIIIO. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VisionImageScroller;
@protocol VisionImageScrollerDelegate <NSObject>

@optional
- (void)visionImageScroller:(VisionImageScroller *)scroller didSelectImageAtIndex:(NSInteger)index;
@end

/**分頁圖片輪播器 unlimited image page scroller
 此輪播器為輪播器基類，並未實現圖片賦值，需要在子類中實現 this class is the base class that doesn't implement setImage method.SetImage method should be implemented in subclass
 */
@interface VisionImageScroller : UIView
@property (weak,nonatomic) id<VisionImageScrollerDelegate> delegate;

@property (strong,nonatomic) UIScrollView *scrollView;
@property (strong,nonatomic) UIPageControl *pageControl;
/** 圖片數據源，遠程圖片應該使用圖片URL地址，本地圖片應該直接使用UIImage. Source of images which should contains URLs for remote images or UIImages for local images directly */
@property (strong,nonatomic) NSArray *imageArray;
@property (assign,nonatomic) BOOL shouldAutoPlay;
@property (assign,nonatomic) double autoPlayInterval;
@property (strong,nonatomic,readonly) UIImage *currentImage;
@property (strong,nonatomic) UIImage *placeholderImage;

- (VisionImageScroller *)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray;
- (VisionImageScroller *)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray autoPlay:(BOOL)shouldAutoPlay;
- (void)setImageArray:(NSArray *)imageArray;
- (void)showImageAtIndex:(NSInteger)index;

/** 必須在子類中複寫 MUST be overwritten in subclass*/
- (void)setImageOfImageView:(UIImageView *)imgv forIndex:(NSInteger)index;
@end
