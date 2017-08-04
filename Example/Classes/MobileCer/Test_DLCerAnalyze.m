//
//  Test_DLCerAnalyze.m
//  DLKit
//
//  Created by ice on 2017/8/4.
//  Copyright © 2017年 707689817@qq.com. All rights reserved.
//

#import "Test_DLCerAnalyze.h"
#import "DLCerAnalyze.h"

@implementation Test_DLCerAnalyze

+ (void)test{
    NSLog(@"证书内容:\n %@\n 证书名称: %@\n 证书ID: %@\n provisionExpTime = %@ \n cerExpireTime = \n",[DLCerAnalyze getMobileProvision],[DLCerAnalyze teamName],[DLCerAnalyze teamID],[DLCerAnalyze provisionExpiredTime]);
    
    [DLCerAnalyze cerExpireTime];
}

@end
