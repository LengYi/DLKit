//
//  PullToRefreshTable+CustomView.m
//  DLKit_Example
//
//  Created by ice on 2017/12/20.
//  Copyright © 2017年 707689817@qq.com. All rights reserved.
//

#import "PullToRefreshTable+CustomView.h"
#import "UIImage+GIF.h"

@implementation PullToRefreshTable (CustomView)
- (void)customPullTitle{
    [self.pullToRefreshView setTitle:@"下拉即可刷新" forState:SVPullToRefreshStateStopped];
    [self.pullToRefreshView setTitle:@"松开立即更新" forState:SVPullToRefreshStateTriggered];
    [self.pullToRefreshView setTitle:@"正在加载中..." forState:SVPullToRefreshStateLoading];
    
    UIView *arrow = (UIView *)[self.pullToRefreshView valueForKey:@"arrow"];
    [arrow removeFromSuperview];
    UIImageView *pulldownBacImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 104, 104)];
    pulldownBacImage.image = [UIImage sd_animatedGIFNamed:@"pulldown"];
    
    [self.pullToRefreshView setCustomView:pulldownBacImage forState:SVPullToRefreshStateLoading];
}
@end
