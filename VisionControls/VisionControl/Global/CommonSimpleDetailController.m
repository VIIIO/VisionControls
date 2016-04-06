//
//  CommonSimpleDetailController.m
//  VisionControls
//
//  Created by Vision on 16/3/15.
//  Copyright © 2016年 VIIIO. All rights reserved.
//
#import "CommonSimpleDetailController.h"

@interface CommonSimpleDetailController ()
@property (strong,nonatomic) UILabel *lbl_detail;
@end

@implementation CommonSimpleDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _lbl_detail = [[UILabel alloc] init];
    _lbl_detail.textColor = [UIColor grayColor];
    _lbl_detail.numberOfLines = 0;
    _lbl_detail.lineBreakMode = NSLineBreakByCharWrapping;
    _lbl_detail.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:_lbl_detail];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.lbl_detail.text = self.detailText;
    [self resetLabelFrame];
}

- (void)resetLabelFrame{
    _lbl_detail.frame = CGRectMake(10, self.navigationController.navigationBar.frame.size.height + 40, self.view.bounds.size.width -20, self.view.bounds.size.height -10);
    [_lbl_detail sizeToFit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    [self resetLabelFrame];
}
@end
