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
    NLog(@"NLog");
    DLog(@"日志信息 99oiuppp");
    DLog(@"爱你哟");
    DLog(@"9999999");

    NSString *log = [NSString stringWithContentsOfFile:[[DLLog shareInstance] logPath] encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"输出写入文件的日志\n %@",log);
    
    [self testChineseLog];
    
//    [[DLLog shareInstance] sendLogToEmail:@"707689899@qq.com"
//                                    title:@"错误日志"
//                                  content:@"发送了一个日志附件"
//                                    block:^(UIViewController *vc,BOOL isDismiss) {
//                                        if (isDismiss) {
//                                            [vc dismissViewControllerAnimated:NO completion:nil];
//                                        }else{
//                                            [[[UIApplication sharedApplication] delegate].window.rootViewController presentViewController:vc
//                                                                                                                                 animated:YES
//                                                                                                                               completion:nil];
//                                        }
//                                    }];
}

// 因为有DLChineseLog的存在所以以下能够打印出中文log
+ (void)testChineseLog{
    NSDictionary *dict = @{@"名字" : @"杰克",
                           @"年龄" : @12,
                           @"内容" : @{
                                   @"userName" : @"rose",
                                   @"message" : @"好好学习",
                                   @"testArray" : @[@"数学",
                                                    @"英语",
                                                    @"历史",
                                                    @[
                                                        @"zhangsan",
                                                        @"lisi",
                                                        @[
                                                            @"test1",
                                                            @"test2",
                                                            @"test3"
                                                            ],
                                                        ],
                                                    ],
                                   @"test" : @{
                                           @"key1" : @"测试1",
                                           @"键值2" : @"test2",
                                           @"key3" : @"test3"
                                           }
                                   
                                   },
                           
                           
                           };
    NSLog(@"%@", dict);
}
@end
