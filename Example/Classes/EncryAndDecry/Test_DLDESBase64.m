//
//  Test_DLDESBase64.m
//  DLKit
//
//  Created by ice on 17/4/20.
//  Copyright © 2017年 707689817@qq.com. All rights reserved.
//

#import "Test_DLDESBase64.h"
#import "DLDESBase64.h"

@implementation Test_DLDESBase64

+ (void)test{
    NSString *enStr = [DLDESBase64 encryptText:@"http://update.xingyuncap.com/req/?t=10000&token=Nx8jD95vSVy8ewB5p76R6g" key:@"NSString"];
    NSString *desStr = [DLDESBase64 desText:enStr key:@"NSString"];
    
    NSLog(@"加密后字符串 = %@,解密后原始字符串 = %@",enStr,desStr);
}

@end
