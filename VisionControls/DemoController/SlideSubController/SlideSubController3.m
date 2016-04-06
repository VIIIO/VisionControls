//
//  SlideSubController3.m
//  VisionControls
//
//  Created by Vision on 16/3/17.
//  Copyright © 2016年 VIIIO. All rights reserved.
//

#import "SlideSubController3.h"

@interface SlideSubController3 ()

@end

@implementation SlideSubController3

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}

- (void)setUp{
    NSInteger no = 3;
    UIColor *clr = [UIColor orangeColor];
    
    self.view.backgroundColor = clr;
    UILabel *lbl = [[UILabel alloc] initWithFrame:(CGRectMake(0, self.view.center.y, self.view.bounds.size.width, 20))];
    lbl.text = [NSString stringWithFormat:@"Controller: %zi",no];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.textColor = [UIColor whiteColor];
    [self.view addSubview:lbl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
