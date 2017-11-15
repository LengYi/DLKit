//
//  LoadingView.m
//  DLKit
//
//  Created by ice on 2017/11/15.
//  Copyright © 2017年 707689817@qq.com. All rights reserved.
//

#import "LoadingView.h"

@implementation LoadingView

+ (void)setOnView:(UIView *)view
        withTitle:(NSString *)title
        withImage:(UIImage *)image
         animated:(BOOL)animated{
    LoadingView *loadingView = [[LoadingView alloc] initWithFrame:view.bounds];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 279, 227)];
    imageView.image = image;
    imageView.center = CGPointMake(view.center.x, view.center.y - 64);
    [loadingView addSubview:imageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
    titleLabel.text = title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.center = CGPointMake(view.center.x, view.center.y - 20);
    [loadingView addSubview:titleLabel];
    
    loadingView.backgroundColor = [UIColor whiteColor];
    [view addSubview:loadingView];
}

+ (BOOL)hideFromView:(UIView *)view animated:(BOOL)animated{
    LoadingView *loadingView = [LoadingView loadingViewFromView:view];
    if (loadingView) {
        [UIView
         animateWithDuration:0.3
         animations:^{
             loadingView.alpha = 0;
         } completion:^(BOOL finished) {
             [loadingView removeFromSuperview];
         }];
        return YES;
    }
    return NO;
}

+ (LoadingView *)loadingViewFromView:(UIView *)view{
    LoadingView *loadingView = nil;
    NSArray *subViewsArray = view.subviews;
    Class hudClass = [LoadingView class];
    for (UIView *aView in subViewsArray) {
        if ([aView isKindOfClass:hudClass]) {
            loadingView = (LoadingView *)aView;
        }
    }
    return loadingView;
}

@end
