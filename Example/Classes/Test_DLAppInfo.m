//
//  Test_DLAppInfo.m
//  DLKit
//
//  Created by ice on 17/4/20.
//  Copyright © 2017年 707689817@qq.com. All rights reserved.
//

#import "Test_DLAppInfo.h"
#import "DLAppInfo.h"

@implementation Test_DLAppInfo

+ (void)test{
    NSLog(@"bundleDisplayName = %@,bundleName = %@,bundleVersion = %@,bundleShortVersion = %@,bundleIdentifier = %@",[DLAppInfo bundleDisplayName],[DLAppInfo bundleName],[DLAppInfo bundleVersion],[DLAppInfo bundleShortVersion],[DLAppInfo bundleIdentifier]);
}

@end
