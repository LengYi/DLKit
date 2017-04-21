//
//  Test_DLHttp.m
//  DLKit
//
//  Created by ice on 17/4/20.
//  Copyright © 2017年 707689817@qq.com. All rights reserved.
//

#import "Test_DLHttp.h"
#import "DLHttp.h"
#import "UIDevice+extended.h"

@implementation Test_DLHttp

+ (void)test{
    NSString *outsideVersion = @"1.0.1";//[ABTarget bundleShortVersion];
    NSString *sku       =   @"com.test110";//[ABTarget bundleIdentifier];
    NSString *idfa      =   [UIDevice idfa];
    NSString *idfv      =   [UIDevice idfv];
    NSString *devVer    =   @"1000";
    NSString *sn = @"";
    
    NSString *postString = [NSString stringWithFormat:@"sku=%@&idfa=%@&idfv=%@&sn=%@&ver=%@&devver=%@",sku,idfa,idfv,sn,outsideVersion,devVer];
    NSData *postData = [NSData dataWithBytes:[postString UTF8String] length:[postString length]];
    
    [DLHttp synWithPostURLString:@"http://update.xingyuncap.com/req/?t=10000&token=Nx8jD95vSVy8ewB5p76R6g"
                        withData:postData
                 withHeaderField:nil
             withTimeoutInterval:10
                  withForeground:YES
                 shouldURLEncode:NO
               completionHandler:^(NSData *data, NSError *error, NSHTTPURLResponse *response) {
                   NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                   NSLog(@"resultDic = %@",resultDic);
               }];
    
    [DLHttp synWithPostURLString:@"http://update.xingyuncap.com/req/?t=10000&token=Nx8jD95vSVy8ewB5p76R6g"
                        withData:postData
                 withHeaderField:nil
             withTimeoutInterval:10
                  withForeground:YES
                 shouldURLEncode:NO
               completionHandler:^(NSData *data, NSError *error, NSHTTPURLResponse *response) {
                   NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                   NSLog(@"resultDic111 = %@",resultDic);
               }];
    
    
    [DLHttp asynWithGetURLString:@"http://data.idown.hk/tuiexe/sku.aspx"
                 withHeaderField:nil
             withTimeoutInterval:0
                  withForeground:YES
                    shouldEncode:YES
               completionHandler:^(NSData *data, NSError *error, NSHTTPURLResponse *response) {
                   NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                   NSLog(@"----- %@",responseObject);
               }];
    
    [DLHttp  synWithGetURLString:@"http://data.idown.hk/tuiexe/sku.aspx"
                 withHeaderField:nil
             withTimeoutInterval:0
                    shouldEncode:YES
               completionHandler:^(NSData *data, NSError *error, NSHTTPURLResponse *response) {
                   NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                   NSLog(@"----2344- %@",responseObject);
               }];
}

@end
