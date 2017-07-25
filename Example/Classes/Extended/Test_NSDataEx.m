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
    NSLog(@"\n %@ data = %@\n",str,data);
    
    NSDictionary *dict = @{@"base64" : @"json str....."};
    NSData *jsonData = [NSData dictToJsonData:dict];
    NSDictionary *jsonDict = [NSData jsonDataToDict:jsonData];
    NSLog(@"\n jsonData = %@ \n jsonDict = %@ \n",jsonData,jsonDict);
}

@end
