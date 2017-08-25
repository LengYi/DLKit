//
//  CircleBannerViewController.m
//  DLKit
//
//  Created by ice on 2017/8/25.
//  Copyright © 2017年 707689817@qq.com. All rights reserved.
//

#import "CircleBannerViewController.h"
#import "ADCircleBannerView.h"

@interface CircleBannerViewController ()<ADCircleBannerViewDelegate,ADCircleBannerViewDataSource>
@property (nonatomic,strong) ADCircleBannerView *adBannerView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation CircleBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self loadData];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 585) / 2, 0, 585, 288)];
    bgView.clipsToBounds = YES;
    [bgView addSubview:self.adBannerView];
    [self.view addSubview:bgView];
}

- (ADCircleBannerView *)adBannerView{
    if (!_adBannerView) {
        _adBannerView = [[ADCircleBannerView alloc] initWithFrame:CGRectMake(0, 0,585,288)];
        _adBannerView.pageControl.pageIndicatorImage = [UIImage imageNamed:@"ad_banner_rectangle"];
        _adBannerView.pageControl.pageIndicatorMaskImage = [UIImage imageNamed:@"ad_banner_circle"];
        _adBannerView.backgroundImaegView.image = [UIImage imageNamed:@"ad_banner_background"];
        _adBannerView.delegate = self;
        _adBannerView.dataSource = self;
    }
    
    return _adBannerView;
}

- (void)loadData{
        _dataArray = [[NSMutableArray alloc] initWithArray:@[
                                                             [UIImage imageNamed:@"banner_0.jpg"],
                                                             [UIImage imageNamed:@"banner_1.jpg"],
                                                             [UIImage imageNamed:@"banner_2.jpg"],
                                                             [UIImage imageNamed:@"banner_3.jpg"],
                                                             [UIImage imageNamed:@"banner_4.jpg"],
                                                             [UIImage imageNamed:@"banner_5.jpg"]]];
}

#pragma mark - ADCircleBannerViewDataSource
- (NSInteger)numberOfPagesADCircleBannerView:(ADCircleBannerView *)bannerView{
    return self.dataArray.count;
}

- (UIView *)adBannerView:(ADCircleBannerView *)bannerView pageAtIndex:(NSInteger)index{
    UIImage *img = self.dataArray[index];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,585,288)];
    imageView.image = img;
    return imageView;
}

#pragma mark - ADCircleBannerViewDelegate
- (void)circleBannerView:(ADCircleBannerView *)bannerView didClickPageIndex:(NSInteger)index{
    NSLog(@"点击了第 %d 个 轮播视图");
}
@end
