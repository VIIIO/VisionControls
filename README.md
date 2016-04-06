VisionControls
=====
* Group of objective-c vision controls that make your coding easier.
* Vision系列控件，让您的编程更容易。

### Screenshots
![image](http://blog.viiio.com/wp-content/uploads/2016/04/visioncontrols.jpg)

### Contents
## Installation 安装

* Just drag `VisionControl` folder into your project
* 将`VisionControl`文件夹拖入你的項目

## Controls 包含组件
#### 1、[VisionCaptureControl](https://github.com/VIIIO/VisionCaptureControl "VisionCaptureControl")
* An oc barcode/QRcode recognizer based on iOS AVCaptureDevice. 
* 基于IOS7+自带条码识别器的自适应条码/二维码扫描控件。

#### 2、[VisionPicker](https://github.com/VIIIO/VisionPicker "VisionPicker")
* A simple oc value picker based on DownPicker(MIT License) which supports key-value selection
* 简单实用的基於DownPicker(MIT License)的二次封裝Picker（Selector/DropdownList/ComboBox）,实现选择结果键值分离

#### 3、[VisionDatePicker](https://github.com/VIIIO/VisionDatePicker "VisionDatePicker")
* A simple and highly customizable oc date picker
* 简单易用、可高度自定义的日期选择控件

#### 4、[VisionRemoteImageScroller](https://github.com/VIIIO/VisionRemoteImageScroller "VisionRemoteImageScroller")
* VisionRemoteImageScroller provides infinite scroll on a group of remote images which could autoplay with a specified interval. Scrollable horizontally only. Remote images are loaded by [SDWebImage](https://github.com/rs/SDWebImage/ "SDWebImage"), please install it first.
* 非常实用、可自动播放的图片滑动器（类似幻灯片效果），可在水平方向无限滚动。图片远程加载依赖于[SDWebImage](https://github.com/rs/SDWebImage/ "SDWebImage")

#### 5、[VisionLocalImageScroller](https://github.com/VIIIO/VisionLocalImageScroller "VisionLocalImageScroller")
* VisionLocalImageScroller provides infinite scroll on a group of local images which could autoplay with a specified interval. Scrollable horizontally only.
* VisionRemoteImageScroller仅加载本地图片版

#### 6、[VisionSinglePhotoPicker](https://github.com/VIIIO/VisionSinglePhotoPicker "VisionSinglePhotoPicker")
* VisionSinglePhotoPicker provides a simplest way to get a SINGLE photo.
* 超方便的单张照片获取器。支持拍照/图库选择，已处理权限获取。

#### 7、[VisionSlideSegmentView](https://github.com/VIIIO/VisionSlideSegmentView "VisionSlideSegmentView")
*  Advanced segmentControl which supports infinite items. Scrollable horizontally only. You could replace UISegmentControl with VisionSlideSegmentView directly.
* 可在水平方向上无限延长的分段选择器，可直接替代UISegmentControl使用。

#### 8、[VisionSlideViewController](https://github.com/VIIIO/VisionSlideViewController "VisionSlideViewController")
* Advanced pageViewController which could switch page by titleView of navigation bar and supports infinite pages. This controller should be inherited, so please create a subclass when using it.
* 可直接通過导航栏进行分页切换的布局容器，不限制分页数量。本Controller为基类，实际项目中需要继承使用(subClass)。


## Requirements 要求
* iOS 6 or later. Some of them requires iOS8+. Requires ARC  ,support iPhone/iPad.
* iOS 6及以上系统可使用. 部分控件需要iOS8+. 纯ARC，支持iPhone/iPad横竖屏

## More 更多 

Please create a issue if you have any questions.
Welcome to visit my [Blog](http://blog.viiio.com/ "Vision的博客")

## Licenses
All source code is licensed under the [MIT License](https://github.com/VIIIO/VisionControls/blob/master/LICENSE "License").

