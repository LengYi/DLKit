//
//  Test_NSMutableArray+Safe.m
//  DLKit
//
//  Created by ice on 2017/7/25.
//  Copyright © 2017年 707689817@qq.com. All rights reserved.
//

#import "Test_NSMutableArray+Safe.h"

@implementation Test_NSMutableArray_Safe
+ (void)test{
    NSMutableArray *array = [@[@"value",@"value1"] mutableCopy];
    
    [array lastObject];
    [array removeObject:@"value"];
    [array removeObject:nil];
    
    [array addObject:@"12"];
    [array addObject:nil];
    
    [array insertObject:nil atIndex:0];
    [array insertObject:@"sdf" atIndex:10];
    
    [array objectAtIndex:100];
    [array removeObjectAtIndex:10];
    
    NSMutableArray *anotherArray = [[NSMutableArray alloc] init];
    [anotherArray objectAtIndex:0];
    
    NSString *nilStr = nil;
    NSArray *array1 = @[@"ara", @"sdf", @"dsfdsf", nilStr];
    NSLog(@"array1.count = %lu", array1.count);
}
@end
