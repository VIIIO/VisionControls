//
//  SlideSubController5.m
//  VisionControls
//
//  Created by Vision on 16/3/17.
//  Copyright © 2016年 VIIIO. All rights reserved.
//

#import "SlideSubController5.h"

@interface SlideSubController5 ()

@end

@implementation SlideSubController5

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}

- (void)setUp{
    NSInteger no = 5;
    UIColor *clr = [UIColor greenColor];
    
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
