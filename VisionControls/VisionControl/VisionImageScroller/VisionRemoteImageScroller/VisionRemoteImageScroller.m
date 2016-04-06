//
//  VisionRemoteImageScroller.h
//  VisionControls
//
//  Created by Vision on 16/3/15.
//  Copyright © 2016年 VIIIO. All rights reserved.
//

#import "VisionRemoteImageScroller.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation VisionRemoteImageScroller

- (void)setImageOfImageView:(UIImageView *)imgv forIndex:(NSInteger)index{
    [imgv sd_setImageWithURL:[NSURL URLWithString:self.imageArray[index]] placeholderImage:self.placeholderImage options:SDWebImageRetryFailed];
}
@end
