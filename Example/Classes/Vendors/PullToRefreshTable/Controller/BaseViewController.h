//
//  BaseViewController.h
//  DLKit
//
//  Created by ice on 2017/11/15.
//  Copyright © 2017年 707689817@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetReachability.h"

@interface BaseViewController : UIViewController

/**
 *  网络发生变化产生的回调方法,子类重写该方法即可
 *
 *  @param status 网络状态 wifi/3G/无网络
 */
- (void)reachabilityChanged:(ABNetworkStatus)status;

@end
