//
//  HHPageControl.h
//  原 RSPageControl.h
//
//  Created by hehai on 2016/5/28.
//  Copyright (c) 2016年 hehai. All rights reserved.
//  GitHub:https://github.com/riversea2015
//

#import "HHPageControl.h"

static const NSInteger HHPageControl_BaseTag = 2018092001;

@interface HHPageControl ()

/// 总页数
@property (nonatomic , assign)NSInteger pageNumbers;
/// 未选中的图片
@property (nonatomic , strong)UIImage *normalDotImage;
/// 选中的图片
@property (nonatomic , strong)UIImage *highlightedDotImage;
/// dot图片长度
@property (nonatomic , assign)CGFloat dotLength;
/// dot图片高度
@property (nonatomic , assign)CGFloat dotHeight;
/// dot图片间距
@property (nonatomic , assign)CGFloat dotGap;

@end


@implementation HHPageControl {
    CGFloat tmpX;           // 第一个点在self中的x坐标
    CGFloat tmpY;           // 第一个点在self中的Y坐标
    NSInteger currentIndex; // 当前选中的下标
    CGRect tmpFrame;        // pageControl的frame
}

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame
                  normalImage:(UIImage *)nImage
             highlightedImage:(UIImage *)hImage
                   dotsNumber:(NSInteger)pageNum
                      dotSize:(CGSize)size
                       dotGap:(CGFloat)gap
{
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
        
        self.normalDotImage = nImage;
        self.highlightedDotImage = hImage;
        
        self.dotLength = size.width > 0 ? size.width : nImage.size.width;
        self.dotHeight = size.height > 0 ? size.height : nImage.size.height;
        self.dotGap = MAX(10, gap);
        
        tmpFrame = frame;
        
        if (pageNum) {
            self.pageNumbers = pageNum;
        }
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_normalDotImage || _highlightedDotImage) {
        for (int i = 0 ; i < _pageNumbers; i++) {
            
            UIImageView *dot = self.subviews[i];
            
            if (i == currentIndex) {
                
                dot.frame = CGRectMake(tmpX + (_dotGap + _dotHeight) * i, tmpY, _dotLength, _dotHeight);
            } else if(i < currentIndex) {
                
                dot.frame = CGRectMake(tmpX + (_dotGap + _dotHeight) * i, tmpY, _dotHeight, _dotHeight);
            } else {
                
                dot.frame = CGRectMake(tmpX + (_dotGap + _dotHeight) * (i - 1) + (_dotGap + _dotLength), tmpY, _dotHeight, _dotHeight);
            }
        }
    }
}

#pragma mark - Action

- (void)dotDidTouched:(id)sender {
    
    if (([[sender view] tag] - HHPageControl_BaseTag) == currentIndex) {
        return;
    }
    
    [self setCurrentPage:[[sender view] tag] - HHPageControl_BaseTag];
    
    if (_delegate && [_delegate respondsToSelector:@selector(hh_pageControl:didClickDot:)]) {
        [_delegate hh_pageControl:self didClickDot:[[sender view] tag] - HHPageControl_BaseTag];
    }
}

#pragma mark - Setter & Getter

- (void)setCurrentPage:(NSInteger)page {
    
    NSLog(@"%ld", (long)page);
    
    if (_normalDotImage || _highlightedDotImage) {
        for (int i = 0 ; i < _pageNumbers; i++) {
            
            UIImageView *dot = self.subviews[i];
            
            if (i == page) {
                
                dot.image = _highlightedDotImage;
            } else {
                
                dot.image = _normalDotImage;
            }
        }
        currentIndex = page;
    }
    [self layoutSubviews];
}

- (void)setPageNumbers:(NSInteger)pageNumbers {
    _pageNumbers = pageNumbers;
    
    CGFloat tmpWidth = (_pageNumbers - 1) * (_dotHeight + _dotGap) + _dotLength;
    tmpX = (tmpFrame.size.width - tmpWidth)/2;
    tmpY = (tmpFrame.size.height - _dotHeight)/2;
    
    for (int i = 0; i < _pageNumbers; i++) {
        UIImageView *dotView = [[UIImageView alloc] init];
        dotView.userInteractionEnabled = YES;
        
        dotView.frame = CGRectMake(tmpX + (_dotLength + _dotGap) * i, tmpY, _dotHeight, _dotHeight);
        
        if (i == 0) {
            dotView.frame = CGRectMake(tmpX, tmpY, _dotLength, _dotHeight);
        }
        
        dotView.tag = HHPageControl_BaseTag + i;
        if (i == 0) {
            dotView.image = _highlightedDotImage;
        } else {
            dotView.image = _normalDotImage;
        }
        
        UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dotDidTouched:)];
        [dotView addGestureRecognizer:gestureRecognizer];
        [self addSubview:dotView];
    }
    
    currentIndex = 0;
}

@end
