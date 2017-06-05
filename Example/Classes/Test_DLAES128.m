//
//  Test_DLAES128.m
//  DLKit
//
//  Created by ice on 2017/5/26.
//  Copyright © 2017年 707689817@qq.com. All rights reserved.
//

#import "Test_DLAES128.h"
#import "DLAES128.h"

@implementation Test_DLAES128

+ (void)test{
    NSString *orignStr = @"Hellowrold!!!";
    NSString *key = @"uyi987+";
    NSString *iv = @"opilk";
    NSString *enStr = [DLAES128 encryptStr:orignStr
                                       key:key
                                        iv:iv];
    
    NSString *deStr = [DLAES128 decryStr:enStr
                                     key:key
                                      iv:iv];
    NSLog(@"AES128加密 ====> \n orignStr = %@, \n enStr = %@ \n",orignStr,enStr);
    NSLog(@"AES128解密 ====> \n enStr = %@, \n deStr = %@ \n",enStr,deStr);
}

@end
