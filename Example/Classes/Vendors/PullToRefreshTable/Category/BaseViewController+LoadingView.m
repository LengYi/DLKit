//
//  BaseViewController+LoadingView.m
//  DLKit
//
//  Created by ice on 2017/11/15.
//  Copyright © 2017年 707689817@qq.com. All rights reserved.
//

#import "BaseViewController+LoadingView.h"
#import "LoadingView.h"
#import "UIImage+GIF.h"

@implementation BaseViewController (LoadingView)

- (void)addLoadingView{
    [LoadingView setOnView:self.view
                 withTitle:@"加载中..."
                 withImage:[UIImage sd_animatedGIFNamed:@"searchLoading"]
                  animated:YES];
}

- (void)removeLoadingView{
    [LoadingView hideFromView:self.view animated:YES];
}

@end
