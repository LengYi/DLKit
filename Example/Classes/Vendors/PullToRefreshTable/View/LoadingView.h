//
//  LoadingView.h
//  DLKit
//
//  Created by ice on 2017/11/15.
//  Copyright © 2017年 707689817@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView

+ (void)setOnView:(UIView *)view
        withTitle:(NSString *)title
        withImage:(UIImage *)image
         animated:(BOOL)animated;

+ (BOOL)hideFromView:(UIView *)view animated:(BOOL)animated;

@end
