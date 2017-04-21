//
//  Test_DLDocumentPath.m
//  DLKit
//
//  Created by ice on 17/4/20.
//  Copyright © 2017年 707689817@qq.com. All rights reserved.
//

#import "Test_DLDocumentPath.h"
#import "DLDocumentPath.h"

@implementation Test_DLDocumentPath

+ (void)test{
    NSString *homePath = [DLDocumentPath homePath];
    NSString *documentPath = [DLDocumentPath documentPath];
    NSString *tmpPath = [DLDocumentPath tmpPath];
    NSString *cachePath = [DLDocumentPath cachePath];
    
    NSLog(@"\n homePath = %@\n homePath+fileName = %@\n documentPath = %@\n doucumentPath+fileName = %@\n tmpPath = %@\n tmpPath+fileName = %@\n cachePath = %@\n cachePath+fileName = %@\n",homePath,[DLDocumentPath homePathWithFileName:@"test"],documentPath,[DLDocumentPath documentPathWithFileName:@"test"],tmpPath,[DLDocumentPath tmpPathWithFileName:@"test"],cachePath,[DLDocumentPath cachePathWithFileName:@"test"]);
}

@end
