//
//  VisionImageScroller.h
//  VisionControls
//
//  Created by Vision on 16/3/15.
//  Copyright © 2016年 VIIIO. All rights reserved.
//


#import "VisionImageScroller.h"

@interface VisionImageScroller()<UIScrollViewDelegate> {
    int _no_totalPage;
    int _no_currentPage;
    NSTimer *_timer;
    NSMutableArray *_imageArrayCache;
}
@end

@implementation VisionImageScroller
- (VisionImageScroller *)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray{
    return [self initWithFrame:frame imageArray:imageArray autoPlay:YES];
}

- (VisionImageScroller *)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray autoPlay:(BOOL)shouldAutoPlay{
    self = [super initWithFrame:frame];
    if (self) {
        //init placeholder
        if (!self.placeholderImage) {
            self.placeholderImage = [UIImage imageNamed:@"visionImageScroller-no-pictures"];
        }
        self.backgroundColor = [UIColor clearColor];
        //Create Scroll View
        self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.scrollView.contentSize = CGSizeMake(frame.size.width*5, frame.size.height);
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.delegate = self;
        //Attach GestureRecognizer
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedOnImage:)];
        recognizer.numberOfTapsRequired = 1;
        recognizer.numberOfTouchesRequired = 1;
        [self.scrollView addGestureRecognizer:recognizer];
        //Create ImageViews
        for (int i=0 ; i<3; i++) {
            UIImageView *imgv = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width*i, 0, frame.size.width, frame.size.height)];
            imgv.userInteractionEnabled = NO;
            imgv.tag = 100+i;
            imgv.image = self.placeholderImage;
            [self.scrollView addSubview:imgv];
        }
        [self addSubview:self.scrollView];
        //Create Pagecontrol
        self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(frame.size.width/2-40, frame.size.height-30, 80, 20)];
        self.pageControl.currentPage = 0;
        self.pageControl.numberOfPages = 10;
        self.pageControl.userInteractionEnabled = NO;
        [self addSubview:self.pageControl];
        if (imageArray) {
            [self setImageArray:imageArray];
        }
        //autoplay
        self.shouldAutoPlay = shouldAutoPlay;
    }
    return self;
}

- (void)setImageArray:(NSArray *)imageArray{
    _imageArray = imageArray;
    //Reset Images and page paras
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = imageArray.count;
    _no_totalPage = (int)imageArray.count;
    _no_currentPage = 0;
    [self resetCurrentImageGroup];
    [self.scrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
}

- (UIImage *)currentImage{
    UIImage *_currentImage = _imageArray.count > 0 ? ((UIImageView *)[self.scrollView viewWithTag:(101)]).image : self.placeholderImage;
    return _currentImage;
}

- (void)setAutoPlayInterval:(double)autoPlayInterval{
    _autoPlayInterval = autoPlayInterval;
    [self stopPlaying];
    [self startToPlay];
}

- (void)setShouldAutoPlay:(BOOL)shouldAutoPlay{
    _shouldAutoPlay = shouldAutoPlay;
    [self stopPlaying];
    if (_shouldAutoPlay) {
        [self startToPlay];
    }
}

- (void)setPlaceholderImage:(UIImage *)placeholderImage{
    _placeholderImage = placeholderImage;
    if (placeholderImage) {
        self.imageArray = self.imageArray;//resetImageArray
    }
}

- (void)tappedOnImage:(UITapGestureRecognizer *)recognizer{
    if ([self.delegate respondsToSelector:@selector(visionImageScroller:didSelectImageAtIndex:)]) {
        [self.delegate visionImageScroller:self didSelectImageAtIndex:self.pageControl.currentPage];
    }
}

//handle rotation
- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    if (self.scrollView) {
        [UIView animateWithDuration:0.2 animations:^{
            self.scrollView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
            self.scrollView.contentSize = CGSizeMake(frame.size.width*5, frame.size.height);
            for (int i=0 ; i<3; i++) {
                UIImageView *imgv = [self.scrollView viewWithTag:100+i];
                imgv.frame = CGRectMake(frame.size.width*i, 0, frame.size.width, frame.size.height);
            }
            self.pageControl.frame = CGRectMake(frame.size.width/2-40, frame.size.height-30, 80, 20);
            [self.scrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
        }];
    }
}
#pragma mark - Scroller
- (void)scrollToNextPage{
    [self.scrollView setContentOffset:CGPointMake(2*self.scrollView.frame.size.width, 0) animated:YES];
}

- (void)startToPlay{
    if (self.shouldAutoPlay) {
        if (_no_totalPage != 0) {
            _timer = [NSTimer timerWithTimeInterval:self.autoPlayInterval<=0? 4: self.autoPlayInterval target:self selector:@selector(scrollToNextPage) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        }
    }
}

- (void)stopPlaying{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)resetCurrentImageGroup{
    NSArray *arr_index = [self calcVisiblePageIndex];
    for (int i=0; i<3; i++) {
        UIImageView *imgv = (UIImageView *)[self.scrollView viewWithTag:(i+100)];
        int no_index = [arr_index[i] intValue];
        if (no_index < self.imageArray.count) {
            [self setImageOfImageView:imgv forIndex:no_index];
        }else{
            imgv.image = self.placeholderImage;
        }
    }
}

- (NSArray *)calcVisiblePageIndex{
    if (_no_totalPage == 0) {
        return @[@1,@1,@1];
    }
    if (_no_currentPage > _no_totalPage - 1) {
        _no_currentPage = 0;
    }else if(_no_currentPage < 0){
        _no_currentPage = _no_totalPage - 1;
    }
    int no_index_0 = (_no_totalPage - 1 + _no_currentPage) % _no_totalPage;
    int no_index_1 = _no_currentPage;
    int no_index_2 = (_no_currentPage +1) % _no_totalPage;
    NSArray *arr_index = @[[NSNumber numberWithInt:no_index_0],[NSNumber numberWithInt:no_index_1],[NSNumber numberWithInt:no_index_2]];
    return arr_index;
}

- (void)showImageAtIndex:(NSInteger)index{
    _no_currentPage = (int)index;
    self.pageControl.currentPage = _no_currentPage;
    [self resetCurrentImageGroup];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat scrollViewW = scrollView.frame.size.width;
    CGFloat x = scrollView.contentOffset.x;
    if (x>=2 * scrollViewW || x<=0) {
        if (_no_totalPage>0) {
            int no_pageTick = x>=2 * scrollViewW ? 1 :
            x<=0 ? -1 :
            0;
            _no_currentPage = _no_currentPage + no_pageTick;
            //循环：若超出則返回第一頁，﹣1則為最後一頁；
            [self resetCurrentImageGroup];
            [self.scrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
            self.pageControl.currentPage = _no_currentPage;
            //NSLog(@"%d,%f",_no_currentPage,x);
        }
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self stopPlaying];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self startToPlay];
}

#pragma mark - They MUST be overwritten in subclass
- (void)setImageOfImageView:(UIImageView *)imgv forIndex:(NSInteger)index{

}
@end
