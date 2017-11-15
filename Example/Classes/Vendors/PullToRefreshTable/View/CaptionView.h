//
//  CaptionView.h
//  DLKit
//
//  Created by ice on 2017/11/15.
//  Copyright © 2017年 707689817@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CaptionViewBlock)();

@interface CaptionView : UIView

/**
 *  显示CaptionView
 *
 *  @param view     在那个页面上显示CaptionView
 *  @param title    提示语
 *  @param image    展示图片
 *  @param animated 是否动画
 *  @param block    页面点击回调事件
 */
+ (void)setOnView:(UIView *)view
        withTitle:(NSString *)title
        withImage:(UIImage *)image
         animated:(BOOL)animated
            block:(CaptionViewBlock)block;

/**
 *  移除CaptionView
 *
 *  @param view     移除那个页面上的CaptionView
 *  @param animated 是否动画
 *
 *  @return 是否移除成功
 */
+ (BOOL)hideFromView:(UIView *)view animated:(BOOL)animated;

@end
