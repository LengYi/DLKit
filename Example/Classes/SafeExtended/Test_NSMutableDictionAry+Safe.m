//
//  Test_NSMutableDictionAry+Safe.m
//  DLKit
//
//  Created by ice on 2017/7/25.
//  Copyright © 2017年 707689817@qq.com. All rights reserved.
//

#import "Test_NSMutableDictionAry+Safe.h"

@implementation Test_NSMutableDictionAry_Safe
+ (void)test{
    NSMutableDictionary *dict = [@{@"key":@"value",@"key1":@"value1"} mutableCopy];
    [dict setObject:@"123" forKey:@"oj"];
    [dict setObject:nil forKey:@"op"];
    
    [dict setValue:@"678" forKey:@"kl"];
    [dict setValue:NULL forKey:@"pp"];
    
    [dict removeObjectForKey:@"k1"];
    [dict removeObjectForKey:nil];
}
@end
