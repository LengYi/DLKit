//
//  CaptionView.m
//  DLKit
//
//  Created by ice on 2017/11/15.
//  Copyright © 2017年 707689817@qq.com. All rights reserved.
//

#import "CaptionView.h"

@interface CaptionView ()
@property (nonatomic,strong) CaptionViewBlock block;
@end

@implementation CaptionView

#pragma mark PublicMethod

+ (void)setOnView:(UIView *)view
        withTitle:(NSString *)title
        withImage:(UIImage *)image
         animated:(BOOL)animated
            block:(CaptionViewBlock)block{
    CaptionView *captionView = [[CaptionView alloc] initWithFrame:view.bounds];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 74, 55)];
    imageView.image = image;
    imageView.center = CGPointMake(view.center.x, view.center.y - 30 - 64);
    [captionView addSubview:imageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
    titleLabel.text = title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.center = CGPointMake(view.center.x, view.center.y - 40);
    [captionView addSubview:titleLabel];
    
    captionView.backgroundColor = [UIColor whiteColor];
    [view addSubview:captionView];
    
    if (block) {
        captionView.block = block;
    }
}

+ (BOOL)hideFromView:(UIView *)view animated:(BOOL)animated{
    CaptionView *capView = [CaptionView captionViewFromView:view];
    if (capView) {
        [UIView
         animateWithDuration:0.3
         animations:^{
             capView.alpha = 0;
         } completion:^(BOOL finished) {
             [capView removeFromSuperview];
         }];
        return YES;
    }
    return NO;
}

#pragma mark PrivateMethod

+ (CaptionView *)captionViewFromView:(UIView *)view{
    CaptionView *capView = nil;
    NSArray *subViewsArray = view.subviews;
    Class hudClass = [CaptionView class];
    for (UIView *aView in subViewsArray) {
        if ([aView isKindOfClass:hudClass]) {
            capView = (CaptionView *)aView;
        }
    }
    return capView;
}

// 触摸回调事件
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (self.block) {
        self.block();
    }
}
@end
