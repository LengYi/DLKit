//
//  Test_NSDataEx.m
//  DLKit
//
//  Created by ice on 17/4/24.
//  Copyright © 2017年 707689817@qq.com. All rights reserved.
//

#import "Test_NSDataEx.h"
#import "NSData+Extended.h"

@implementation Test_NSDataEx
+ (void)test{
    NSString *str = @"hello world!";
    NSData *data = [NSData dataFromString:str];
    NSLog(@"\n %@ data = %@",str,data);
}
@end
