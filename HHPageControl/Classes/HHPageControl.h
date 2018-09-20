//
//  HHPageControl.h
//  原 RSPageControl.h
//
//  Created by hehai on 2016/5/28.
//  Copyright (c) 2016年 hehai. All rights reserved.
//  GitHub:https://github.com/riversea2015
//

/**
 *  自定义PageContrl控件，主要功能：
 *  1.实现了setCurrentPage事件
 *  2.dot点击事件
 *  注：如果要使用dot的点击事件，需使用 HHPageControlDelegate
 */

#import <UIKit/UIKit.h>

@class HHPageControl;
@protocol HHPageControlDelegate <NSObject>

 @optional
/// 点击具体的 dot 时，调用此方法
- (void)hh_pageControl:(HHPageControl *)pageControl didClickDot:(NSInteger)dotIndex;

@end

@interface HHPageControl : UIView

/// 代理对象
@property (nonatomic, weak) id<HHPageControlDelegate> delegate;
/// 当前页码
@property (nonatomic, assign) NSInteger currentPage;

/**
 *  创建方法
 *
 *  @param frame   frame(必传)
 *  @param nImage  正常状态的dot图片(必传)
 *  @param hImage  选中状态的dot图片(必传)
 *  @param pageNum 总页数(必传)
 *  @param size    图片size(若传 CGSizeZero，则默认为图片的 size)
 *  @param gap     图片间距(若传 0，则默认为 10)
 *
 *  @return RSPageControl对象
 */
- (instancetype)initWithFrame:(CGRect)frame
                  normalImage:(UIImage *)nImage
             highlightedImage:(UIImage *)hImage
                   dotsNumber:(NSInteger)pageNum
                      dotSize:(CGSize)size
                       dotGap:(CGFloat)gap;

@end
