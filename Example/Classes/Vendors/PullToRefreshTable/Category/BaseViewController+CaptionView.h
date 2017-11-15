//
//  BaseViewController+CaptionView.h
//  DLKit
//
//  Created by ice on 2017/11/15.
//  Copyright © 2017年 707689817@qq.com. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController (CaptionView)

/**
 *  添加CaptionView
 */
- (void)addCaptionView;

/**
 *  移除CaptionView
 */
- (void)removeCaptionView;

/**
 *  子类重写该该方法获取到captionView点击回调事件
 */
- (void)captionViewClickAction;

@end
