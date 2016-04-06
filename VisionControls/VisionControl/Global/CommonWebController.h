//
//  CommonWebController.h
//  VisionControls
//
//  Created by Vision on 16/3/15.
//  Copyright © 2016年 VIIIO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonWebController : UIViewController<UIWebViewDelegate>

@property (copy,  nonatomic) NSString *url;
@property (assign,nonatomic) BOOL showContentLoadingIndicator;
@end
