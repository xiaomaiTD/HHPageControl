//
//  HHViewController.m
//  HHPageControl
//
//  Created by riversea2015 on 09/20/2018.
//  Copyright (c) 2018 riversea2015. All rights reserved.
//  Github: https://github.com/riversea2015
//

#import "HHViewController.h"
#import <HHPageControl/HHPageControl.h>

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

@interface HHViewController ()
<
HHPageControlDelegate,
UIScrollViewDelegate
>

/// 滚动视图
@property (nonatomic, strong) UIScrollView *mainScrollView;
/// 自定义 pageControl
@property (nonatomic, strong) HHPageControl *pageControl;
/// 图片名称数组
@property (nonatomic, strong) NSArray *imgNameArr;

@end

@implementation HHViewController

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Example for HHPageControl";
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self initData];
    [self setupViews];
}

- (void)initData {
    _imgNameArr = @[@"HHPageControl_Scroll_01",
                    @"HHPageControl_Scroll_02",
                    @"HHPageControl_Scroll_03",
                    @"HHPageControl_Scroll_04",
                    @"HHPageControl_Scroll_05",
                    @"HHPageControl_Scroll_06",
                    @"HHPageControl_Scroll_07",
                    @"HHPageControl_Scroll_08"
                    ];
}

- (void)setupViews {
    [self initScrollView];
    [self initPageView];
}

#pragma mark - ScrollView

- (void)initScrollView {
    
    _mainScrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _mainScrollView.contentSize = CGSizeMake(kScreenW*_imgNameArr.count, 0); // kScreenH);
    _mainScrollView.delegate = self;
    _mainScrollView.pagingEnabled = YES;
    _mainScrollView.bounces = NO;
    
    for (int i = 0; i < _imgNameArr.count; i++) {
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenW*i, 0, kScreenW, kScreenH)];
        imgV.contentMode = UIViewContentModeScaleToFill;
        imgV.image = [UIImage imageNamed:[NSString stringWithFormat:@"HHPageControl_Scroll_0%d", i+1]];
        [_mainScrollView addSubview:imgV];
    }
    
    [self.view addSubview:_mainScrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint point = scrollView.contentOffset;
    NSInteger index = round(point.x/scrollView.frame.size.width);
    
    [self.pageControl setCurrentPage:index];
}

#pragma mark - PageView

- (void)initPageView {
    self.pageControl = [[HHPageControl alloc] initWithFrame:CGRectMake(0, kScreenH-60, kScreenW, 30)
                                                normalImage:[UIImage imageNamed:@"HHPageControl_Pic_Green"]
                                           highlightedImage:[UIImage imageNamed:@"HHPageControl_Pic_Red"]
                                                 dotsNumber:_imgNameArr.count
                                                    dotSize:CGSizeMake(20, 20)
                                                     dotGap:30];
    self.pageControl.delegate = self;
    [self.view addSubview:self.pageControl];
}

- (void)hh_pageControl:(HHPageControl *)pageControl didClickDot:(NSInteger)dotIndex {
    
    CGFloat height = _mainScrollView.frame.size.height;
    CGFloat width = _mainScrollView.frame.size.width;
    CGFloat originX = _mainScrollView.frame.size.width * dotIndex;
    CGFloat originY = 0;
    CGRect rect = CGRectMake(originX, originY, width, height);
    
    [_mainScrollView scrollRectToVisible:rect animated:YES];
}

@end
