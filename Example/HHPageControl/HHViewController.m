//
//  HHViewController.m
//  HHPageControl
//
//  Created by riversea2015 on 09/20/2018.
//  Copyright (c) 2018 riversea2015. All rights reserved.
//

#import "HHViewController.h"
#import <HHPageControl/HHPageControl.h>

#define kScreenW [UIScreen mainScreen].bounds.size.width

@interface HHViewController ()
<
HHPageControlDelegate
>

/// 自定义 pageControl
@property (nonatomic, strong) HHPageControl *pageControl;

@end

@implementation HHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Example for HHPageControl";
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.pageControl = [[HHPageControl alloc] initWithFrame:CGRectMake((kScreenW-300)/2, 200, 300, 30)
                                                normalImage:[UIImage imageNamed:@"HHPageControl_Pic_Green"]
                                           highlightedImage:[UIImage imageNamed:@"HHPageControl_Pic_Red"]
                                                 dotsNumber:4
                                                    dotSize:CGSizeMake(20, 20)
                                                     dotGap:30];
    self.pageControl.backgroundColor = [UIColor whiteColor];
    self.pageControl.delegate = self;   // 需要响应 touch event 时，加上这一行。
    [self.view addSubview:self.pageControl];
}

- (void)hh_pageControl:(HHPageControl *)pageControl didClickDot:(NSInteger)dotIndex {
    
    // 点击 HHPageControl 的小点时，要做的事可以放在这里 ^_^
    
}

@end
