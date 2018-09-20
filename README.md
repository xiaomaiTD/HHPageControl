# HHPageControl(RSPageControl)

[![CI Status](https://img.shields.io/travis/riversea2015/HHPageControl.svg?style=flat)](https://travis-ci.org/riversea2015/HHPageControl)
[![Version](https://img.shields.io/cocoapods/v/HHPageControl.svg?style=flat)](https://cocoapods.org/pods/HHPageControl)
[![License](https://img.shields.io/cocoapods/l/HHPageControl.svg?style=flat)](https://cocoapods.org/pods/HHPageControl)
[![Platform](https://img.shields.io/cocoapods/p/HHPageControl.svg?style=flat)](https://cocoapods.org/pods/HHPageControl)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## ScreenShot

![Mou icon](https://github.com/riversea2015/RSPageControl/blob/master/pageControl_1.png?raw=true)
![Mou icon](https://github.com/riversea2015/RSPageControl/blob/master/pageControl_3.gif?raw=true)

## Requirements

## Installation

HHPageControl is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'HHPageControl'
```

## Use

Include HHPageControl wherever you need it with the following line:
```objective-c
#import <HHPageControl/HHPageControl.h>
```
And you should abide by the agreement `HHPageControlDelegate`.

## Author

riversea2015, hehai682@126.com

## License

HHPageControl is available under the MIT license. See the LICENSE file for more info.

---

## 使用方法

1.创建pageControl
```objective-c
    RSPageControl *pageControl = [[RSPageControl alloc] initWithFrame:CGRectMake(pX, pY, pWidth, pHeight) normalImage:[UIImage imageNamed:@"choice_carousel_default"] highlightedImage:[UIImage imageNamed:@"choice_carousel_current"] dotsNumber:4 dotLength:12 dotHeight:5 dotGap:30];
    pageControl.delegate = self; // 需要响应touch事件时，加上这一行
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
```

2.需要切换选中的小圆点时，给currentPage赋值(带注释的那一行)
```objective-c
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint point = scrollView.contentOffset;
    NSInteger index = round(point.x/scrollView.frame.size.width);

    [self.pageControl setCurrentPage:index]; // 设置当前对应的圆点
}
```

3.点击小圆点时，执行此代理方法 - (void)rs_pageControlDidStopAtIndex:
```objective-c
- (void)rs_pageControlDidStopAtIndex:(NSInteger)index {
    NSLog(@"index:%ld", index);

    // 以下为切换图片的方法(由使用者自定义)
    CGFloat height = _scrollView.frame.size.height;
    CGFloat width = _scrollView.frame.size.width;
    CGFloat originX = _scrollView.frame.size.width*index;
    CGFloat originY = 0;

    CGRect rect = CGRectMake(originX, originY, width, height);

    [_scrollView scrollRectToVisible:rect animated:NO];
}
```
