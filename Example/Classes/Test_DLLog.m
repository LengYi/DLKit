//
//  Test_DLLog.m
//  DLKit
//
//  Created by ice on 2017/6/20.
//  Copyright © 2017年 707689817@qq.com. All rights reserved.
//

#import "Test_DLLog.h"
#import "DLLog.h"

@implementation Test_DLLog
+ (void)test{
    NSLog(@"控制台日志");
    DLog(@"日志信息 99oiuppp");
    DLog(@"爱你哟");
    DLog(@"9999999");

    [[DLLog shareInstance] sendLogToEmail:@"707689899@qq.com"
                                    title:@"错误日志"
                                  content:@"发送了一个日志附件"
                                    block:^(UIViewController *vc,BOOL isDismiss) {
                                        if (isDismiss) {
                                            [vc dismissViewControllerAnimated:NO completion:nil];
                                        }else{
                                            [[[UIApplication sharedApplication] delegate].window.rootViewController presentViewController:vc
                                                                                                                                 animated:YES
                                                                                                                               completion:nil];
                                        }
                                    }];
}
@end
