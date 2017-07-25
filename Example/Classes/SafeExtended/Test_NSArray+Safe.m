//
//  Test_NSArray+Safe.m
//  DLKit
//
//  Created by ice on 2017/7/25.
//  Copyright © 2017年 707689817@qq.com. All rights reserved.
//

#import "Test_NSArray+Safe.h"

@implementation Test_NSArray_Safe

+ (void)test{
    NSArray *arrar = [[NSArray alloc] initWithObjects:@"123",nil];
    [arrar objectAtIndex:1];
}

@end
