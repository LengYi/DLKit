//
//  Test_NSStringEx.m
//  DLKit
//
//  Created by ice on 17/4/24.
//  Copyright © 2017年 707689817@qq.com. All rights reserved.
//

#import "Test_NSStringEx.h"
#import "NSString+Encrypto.h"
#import "NSString+Extension.h"
#import "NSData+Extended.h"

@implementation Test_NSStringEx
+ (void)test{
    NSString *str = @"hello world!";
    NSString *md5 = [str MD5];
    NSLog(@"\n %@ md5 = %@ \n ",str,md5);
    
    NSString *sHA1 = [str SHA1];
    NSLog(@"\n %@ SHA1 = %@ \n ",str,sHA1);
    
    NSString *hexString = [NSString hexStringFromData:[NSData dataFromString:str]];
    NSLog(@"\n %@ hexString = %@ \n ",str,hexString);
    
    NSData *originData = [NSString dataFromHexString:hexString];
    NSString *originStr = [NSString stringFromData:originData];
    NSLog(@"\n %@ originData = %@ \n ",str,originData);
    NSLog(@"\n %@ originStr = %@ \n ",str,originStr);
    
    NSString *emailStr = @"xiwe@126.com";
    BOOL isEmail = [emailStr isEmail];
    BOOL isValidEmail = [NSString isValidEmailString:emailStr];
    NSLog(@"\n %@ isEmail = %d isValidEmail = %d \n ",emailStr,isEmail,isValidEmail);
    
    NSString *urlStr = @"http://www.baidu.com";
    BOOL isUrl = [urlStr isUrl];
    NSLog(@"\n %@ isUrl = %d \n ",urlStr,isUrl);
    
    NSString *telNumStr = @"13215013594";
    BOOL isTelNum = [telNumStr isTelephoneNumber];
    NSLog(@"\n %@ isTelNum = %d \n ",telNumStr,isTelNum);
}
@end
