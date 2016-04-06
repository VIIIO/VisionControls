//
//  VisionLocalImageScroller.m
//  VisionControls
//
//  Created by Vision on 16/3/16.
//  Copyright © 2016年 VIIIO. All rights reserved.
//

#import "VisionLocalImageScroller.h"

@implementation VisionLocalImageScroller

- (void)setImageOfImageView:(UIImageView *)imgv forIndex:(NSInteger)index{
    imgv.image = self.imageArray[index];
}

@end
