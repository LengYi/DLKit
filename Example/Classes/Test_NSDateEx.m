//
//  Test_NSDateEx.m
//  DLKit
//
//  Created by ice on 2017/6/21.
//  Copyright © 2017年 707689817@qq.com. All rights reserved.
//

#import "Test_NSDateEx.h"
#import "NSDate+Extended.h"

@implementation Test_NSDateEx
+ (void)test{
    [NSDate compareCurrentTime:[NSDate date]];
    
    NSDate *date = [NSDate date];
    NSLog(@"NSDate->Stirng date = %@,strDate = %@",date,[NSDate stringFromDate:date]);
    NSLog(@"当前时间:%@ \n 年:%d,月:%d,日:%d,时:%d,分:%d,秒:%d,周:%d",date,[date year],[date month],[date day],[date hour],[date miniute],[date second],[date weekDay]);
}
@end
