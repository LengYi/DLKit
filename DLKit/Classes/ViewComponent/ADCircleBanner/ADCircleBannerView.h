//
//  ADCircleBannerView.h
//
//  Created by ice on 15/10/19.
//  Copyright (c) 2015年 tongbu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMPageControl.h"

/** 
 广告轮播组件,支持无限循环轮播，自动轮播
 */
@protocol ADCircleBannerViewDataSource;
@protocol ADCircleBannerViewDelegate;

@interface ADCircleBannerView : UIView
/** 默认背景图 */
@property (nonatomic,strong) UIImageView    *backgroundImaegView;
/** 自动轮播动画时间间隔 */
@property (nonatomic,assign) NSTimeInterval animationInterval;
/** 翻页指示标志控件 */
@property (nonatomic,strong) SMPageControl  *pageControl;
/** 是否自动无限循环 默认YES */
@property (assign) BOOL autoLoop;
/** 数据源代理 */
@property (nonatomic,assign) id<ADCircleBannerViewDataSource>   dataSource;
/** 点击事件代理 */
@property (nonatomic,assign) id<ADCircleBannerViewDelegate>     delegate;

/** 刷新组件 */
- (void)reloadData;

@end


@protocol ADCircleBannerViewDataSource <NSObject>
@required
/** 
 轮播展示的视图个数
 @param bannerView 轮播控件
 */
- (NSInteger)numberOfPagesADCircleBannerView:(ADCircleBannerView *)bannerView;

/**
  配置轮播展示的视图
  @param bannerView 轮播控件
  @param index 轮播视图索引,当前展示的顺序
  @result 自定义被展示的轮播视图
 */
- (UIView *)adBannerView:(ADCircleBannerView *)bannerView pageAtIndex:(NSInteger)index;

@end


@protocol ADCircleBannerViewDelegate <NSObject>
@optional

/**
 轮播视图点击回调事件接口
 @param bannerView 轮播控件
 @param index 被点击轮播视图的索引值
 */
- (void)circleBannerView:(ADCircleBannerView *)bannerView didClickPageIndex:(NSInteger)index;

@end
