//
//  SlideSubController6.m
//  VisionControls
//
//  Created by Vision on 16/3/17.
//  Copyright © 2016年 VIIIO. All rights reserved.
//

#import "SlideSubController6.h"

@interface SlideSubController6 ()

@end

@implementation SlideSubController6

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}

- (void)setUp{
    NSInteger no = 6;
    UIColor *clr = [UIColor blueColor];
    
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
