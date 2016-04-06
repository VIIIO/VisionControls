//
//  VisionSlideViewController.m
//  VisionControls
//
//  Created by Vision on 16/3/17.
//  Copyright © 2016年 VIIIO. All rights reserved.
//

#import "VisionSlideViewController.h"
#import "VisionSlideSegmentView.h"

@interface VisionSlideViewController ()<VisionSlideSegmentViewDelegate>

@property (strong,nonatomic) NSMutableArray *titleArray;
@property (strong,nonatomic) NSMutableArray *viewControllers;
@property (strong,nonatomic) UIPageViewController *pageController;
@property (strong,nonatomic) VisionSlideSegmentView *segmentView;

@property (assign,nonatomic) NSInteger currentPageIndex;
@property (assign,nonatomic) NSInteger controllersCount;
@end

@implementation VisionSlideViewController
#pragma mark - initializition
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}

- (void)setUp{
    self.view.backgroundColor = [UIColor whiteColor];
    self.currentPageIndex = 0;
    [self reloadTitleArray];
    [self reloadViewControllers];
    if (!_titleViewNormalStateColor) {
        _titleViewNormalStateColor = [UIColor lightGrayColor];
    }
    if (!_titleViewSelectedStateColor) {
        _titleViewSelectedStateColor = [UIColor redColor];
    }
    if (!_titleViewFontSize) {
        _titleViewFontSize = [UIFont systemFontSize];
    }
    if (!_titleViewBottomLineHeight) {
        _titleViewBottomLineHeight = 2;
    }
    if (_titleViewWidth <= 0) {
        _titleViewWidth = 200;
    }
    //setup titleView
    if (self.navigationController) {
        _segmentView = [[VisionSlideSegmentView alloc] initWithFrame:(CGRectMake(0, 0, _titleViewWidth, 40))];
        _segmentView.dataArray = self.titleArray;
        _segmentView.delegate = self;
        [self reloadSegmentViewParas];
        self.navigationItem.titleView = _segmentView;
    }
    //setup pageController
    _pageController = [[UIPageViewController alloc] initWithTransitionStyle:(UIPageViewControllerTransitionStyleScroll) navigationOrientation:(UIPageViewControllerNavigationOrientationHorizontal) options:nil];
    _pageController.delegate = self;
    _pageController.dataSource = self;
    [self.view addSubview:self.pageController.view];
    if (self.controllersCount > 0) {
        [self moveToViewControllerAtIndex:0];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - setter & getter
- (NSInteger)controllersCount{
    if (!_controllersCount) {
        _controllersCount = 0;
    }
    if ([self.dataSource respondsToSelector:@selector(numberOfControllersInVisionSlider:)]) {
        _controllersCount  = [self.dataSource numberOfControllersInVisionSlider:self];
    }
    return _controllersCount;
}

- (NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [[NSMutableArray alloc] init];
    }
    return _titleArray;
}

- (NSMutableArray *)viewControllers{
    if (!_viewControllers) {
        _viewControllers = [[NSMutableArray alloc] init];
    }
    return _viewControllers;
}

- (void)setTitleViewNormalStateColor:(UIColor *)titleViewNormalStateColor{
    _titleViewNormalStateColor = titleViewNormalStateColor;
    if (titleViewNormalStateColor) {
        self.segmentView.itemNormalColor = titleViewNormalStateColor;
    }
}

- (void)setTitleViewSelectedStateColor:(UIColor *)titleViewSelectedStateColor{
    _titleViewSelectedStateColor = titleViewSelectedStateColor;
    if (titleViewSelectedStateColor) {
        self.segmentView.itemSelectedColor = titleViewSelectedStateColor;
    }
}

- (void)setTitleViewFontSize:(CGFloat)titleViewFontSize{
    _titleViewFontSize = titleViewFontSize;
    if (titleViewFontSize && titleViewFontSize > 0) {
        self.segmentView.fontSize = titleViewFontSize;
    }
}

- (void)setTitleViewBottomLineHeight:(CGFloat)titleViewBottomLineHeight{
    _titleViewBottomLineHeight = titleViewBottomLineHeight;
    if (titleViewBottomLineHeight && titleViewBottomLineHeight > 0) {
        self.segmentView.lineHeight = titleViewBottomLineHeight;
    }
}

- (void)setTitleViewWidth:(CGFloat)titleViewWidth{
    _titleViewWidth = titleViewWidth;
    if (titleViewWidth && titleViewWidth > 0 && self.segmentView) {
        CGRect frame = self.segmentView.frame;
        frame.size.width = titleViewWidth;
        self.segmentView.frame = frame;
        if (self.navigationController) {
            self.navigationItem.titleView = nil;//important for resetting position
            self.navigationItem.titleView = _segmentView;
        }
    }
}
#pragma mark - pageViewController delegate & dataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSInteger index = [self.viewControllers indexOfObject:viewController];
    return index == NSNotFound || index == 0 ? nil : self.viewControllers[index - 1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSInteger index = [self.viewControllers indexOfObject:viewController];
    return index == NSNotFound || index == self.viewControllers.count - 1 ? nil : self.viewControllers[index + 1];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    if (completed) {
        id _currentViewController = [pageViewController.viewControllers lastObject];
        NSInteger index = [self.viewControllers indexOfObject:_currentViewController];
        //        NSInteger index = pageViewController.viewControllers.firstObject.view.tag;
        if (index != NSNotFound) {
            self.currentPageIndex = index;
            [self didEndDisplayingViewControllerAtIndex:index];
        }
    }
}
#pragma mark - VisionSlideSegmentView delegate
- (void)visionSlideSegmentView:(VisionSlideSegmentView *)view selectedAtIndex:(NSInteger)index{
    [self moveToViewControllerAtIndex:index callSegmentSelect:NO];
}

#pragma mark - VisionSlideViewController methods
#pragma mark public methods
- (void)reloadData{
    [self reloadTitleArray];
    [self reloadViewControllers];
    _segmentView.dataArray = self.titleArray;
    [self reloadSegmentViewParas];
    
    __weak typeof(self) weakSelf = self;
    [self.pageController setViewControllers:@[self.viewControllers[0]] direction:(UIPageViewControllerNavigationDirectionReverse) animated:YES completion:^(BOOL finished) {
        [weakSelf didEndDisplayingViewControllerAtIndex:0];
    }];
}

- (void)moveToViewControllerAtIndex:(NSInteger)index{
    [self moveToViewControllerAtIndex:index callSegmentSelect:YES];
}

- (UIViewController *)viewControllerAtIndex:(NSInteger)index{
    return self.viewControllers[index];
}
#pragma mark private methods
- (void)reloadTitleArray{
    if (self.controllersCount > 0) {
        [self.titleArray removeAllObjects];
        if ([self.dataSource respondsToSelector:@selector(visionSlider:titleForViewControllerAtIndex:)]) {
            for (NSInteger i = 0; i < self.controllersCount; i++) {
                [self.titleArray addObject:[self.dataSource visionSlider:self titleForViewControllerAtIndex:i]];
            }
        }
    }else{
        [self.titleArray removeAllObjects];
    }
}

- (void)reloadViewControllers{
    if (self.controllersCount > 0) {
        [self.viewControllers removeAllObjects];
        if ([self.dataSource respondsToSelector:@selector(visionSlider:viewControllerAtIndex:)]) {
            for (NSInteger i = 0; i < self.controllersCount; i++) {
                [self.viewControllers addObject:[self.dataSource visionSlider:self viewControllerAtIndex:i]];
            }
        }
    }else{
        [self.viewControllers removeAllObjects];
    }
}

- (void)reloadSegmentViewParas{
    self.segmentView.itemNormalColor = self.titleViewNormalStateColor;
    self.segmentView.itemSelectedColor = self.titleViewSelectedStateColor;
    self.segmentView.fontSize = self.titleViewFontSize;
    self.segmentView.lineHeight = self.titleViewBottomLineHeight;
}
/**callSegmentSelect : decide whether segmentView select should be called or not*/
- (void)moveToViewControllerAtIndex:(NSInteger)index callSegmentSelect:(BOOL)callSegmentSelect{
    __weak typeof(self) weakSelf = self;
    [self.pageController setViewControllers:@[self.viewControllers[index]]
                                  direction:(index >= self.currentPageIndex ? UIPageViewControllerNavigationDirectionForward : UIPageViewControllerNavigationDirectionReverse)
                                   animated:YES
                                 completion:^(BOOL finished) {
                                     weakSelf.currentPageIndex = index;
                                     [weakSelf didEndDisplayingViewControllerAtIndex:index callSegmentSelect:callSegmentSelect];
                                 }];
}
- (void)didEndDisplayingViewControllerAtIndex:(NSInteger)index{
    [self didEndDisplayingViewControllerAtIndex:index callSegmentSelect:YES];
}
- (void)didEndDisplayingViewControllerAtIndex:(NSInteger)index callSegmentSelect:(BOOL)callSegmentSelect{
    if (callSegmentSelect) {
        [self.segmentView selectItemAtIndex:index];
    }
    if ([self.delegate respondsToSelector:@selector(visionSlider:didEndDisplayingViewController:atIndex:)]) {
        [self.delegate visionSlider:self didEndDisplayingViewController:self.viewControllers[index] atIndex:index];
    }
}
@end
