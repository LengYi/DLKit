//
//  BaseViewController+CaptionView.m
//  DLKit
//
//  Created by ice on 2017/11/15.
//  Copyright © 2017年 707689817@qq.com. All rights reserved.
//

#import "BaseViewController+CaptionView.h"
#import "CaptionView.h"

@implementation BaseViewController (CaptionView)

- (void)addCaptionView{
    //__weak BaseViewController *weakSelf = self;
    WS(weakSelf);
    [CaptionView setOnView:self.view
                 withTitle:@"网络连接失败,点击屏幕重新加载"
                 withImage:[UIImage imageNamed:@"ipad_no_network"]
                  animated:YES
                     block:^{
                         [weakSelf captionViewClickAction];
                     }];
}

- (void)removeCaptionView{
    [CaptionView hideFromView:self.view animated:YES];
}

- (void)captionViewClickAction{
    
}

@end
