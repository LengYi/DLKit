//
//  Test_DLProtocol.m
//  DLKit
//
//  Created by ice on 17/4/24.
//  Copyright © 2017年 707689817@qq.com. All rights reserved.
//

#import "Test_DLProtocol.h"
#import "DLProtocolAnalyze.h"
#import "DLProtocolPackage.h"
#import "DLByteAndInt.h"
#import "NSData+Extended.h"

@implementation Test_DLProtocol
+ (void)test{
    [self testByteAndInt];
    [self analyzeDataParames];
    [self packageNestedParameter];
}

+ (void)testByteAndInt{
    Byte header[4];
    [DLByteAndInt intToByte:header value:19878];
    
    int value  = [DLByteAndInt ByteToInt:header];
    NSLog(@"19878 转化存储后再读取结果为 = %d",value);
}

// NSData 数据解析还原成数组
+ (void)analyzeDataParames{
    NSData *data = [DLProtocolPackage packageDataWithStringObjects:@"2",@"0",@"38",nil];
    [DLProtocolAnalyze analyzeData:data completion:^(ProtocolAnalyzeCode code, NSArray *arr) {
        NSLog(@"%@ 解析结果 = %@",data,arr);
    }];
}

/*
 * 组装嵌套参数
 *[@"iPhone",@"iOS10",@"1.0.0",@"ice",[@"0",@"1",@"2",[@"7",@"8",@"9"]]]
 *
 */
+ (void)packageNestedParameter{
    
    NSMutableArray *dataArray = [NSMutableArray array];
    for (int i = 0; i < 4; i++) {
        NSString *str = [NSString stringWithFormat:@"%d",i];
        unsigned long len = strlen([str UTF8String]);
        NSData *data = [NSData dataWithBytes:[str UTF8String] length:len];
        [dataArray addObject:data];
        
        if (i == 3) {
            NSMutableArray *arr = [NSMutableArray array];
            for (int j = 0; j < 3; j++) {
                NSString *str = [NSString stringWithFormat:@"%d",j + 7];
                unsigned long len = strlen([str UTF8String]);
                NSData *data = [NSData dataWithBytes:[str UTF8String] length:len];
                [arr addObject:data];
            }
            
            NSData *data = [DLProtocolPackage packageDataWithDataArray:arr];
            [dataArray addObject:data];
        }
    }
    
    NSData *param1 = [NSData dataFromString:@"iPhone"];
    NSData *param2 = [NSData dataFromString:@"iOS10"];
    NSData *param3 = [NSData dataFromString:@"1.0.0"];
    NSData *param4 = [NSData dataFromString:@"ice"];
    
    NSData *data = [DLProtocolPackage packageDataWithDataArray:dataArray];
    
    NSData *postData = [DLProtocolPackage packageDataWithDataArray:@[param1,param2,param3,param4,data]];
    NSLog(@"");
    [DLProtocolAnalyze analyzeData:postData completion:^(ProtocolAnalyzeCode code, NSArray *arr) {
        NSLog(@"%@ 解析结果 = %@",data,arr);
    }];
}

@end
