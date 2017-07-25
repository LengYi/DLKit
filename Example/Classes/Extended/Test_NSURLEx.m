//
//  Test_NSURLEx.m
//  DLKit
//
//  Created by ice on 2017/5/25.
//  Copyright © 2017年 707689817@qq.com. All rights reserved.
//

#import "Test_NSURLEx.h"
#import "NSURL+DLAdditions.h"

@implementation Test_NSURLEx

+ (void)test{
    NSString *urlStr = @"http://129.168.1.1:31812/login2?username=cyx&pwd=123&type=中文&p=%+&sd";
    NSURL *enUrl = [NSURL encodeURLWithString:urlStr];
    NSLog(@"加密URL ====> \n originUrl = %@, \n enUrl = %@ \n ",urlStr,enUrl);
    
    NSString *decodeUrl = [NSURL decodedURLString:[enUrl.absoluteString lowercaseString]];
    NSLog(@"解密URL ====> \n enUrl = %@, \n decodeUrl = %@ \n ",enUrl,decodeUrl);
    
    urlStr = @"http://www.baidu.com?udid=e5b490f27656861a4190996eb47ead1e62d572a6&ver=3.1.2&os=8.0&type=9";
    NSDictionary *paramerDict = [NSURL parseUrlParamers:[NSURL URLWithString:urlStr]];
    NSLog(@"解析URL参数 ====> \n originUrl = %@ \n paramerDict = %@\n",urlStr,paramerDict);
}

@end
