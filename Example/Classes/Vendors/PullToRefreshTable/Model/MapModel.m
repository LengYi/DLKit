//
//  MapModel.m
//  DLKit
//
//  Created by ice on 2017/11/15.
//  Copyright © 2017年 707689817@qq.com. All rights reserved.
//

#import "MapModel.h"
#import "DLHttp.h"

@implementation MapModel

+ (void)requestCityData:(void(^)(BOOL flag,NSArray *array))block{
    [DLHttp asynWithGetURLString:@"http://apis.map.qq.com/ws/district/v1/list?key=K3VBZ-M6WWV-PPSPY-UVGGC-DRM2Z-PGBMV"
                 withHeaderField:nil
             withTimeoutInterval:0
                  withForeground:YES
                    shouldEncode:NO
               completionHandler:^(NSData *data, NSError *error, NSHTTPURLResponse *response) {
                   if (!error) {
                       NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                       if(dic){
                           NSArray *arr = dic[@"result"];
                           NSMutableArray *resultArr = [[NSMutableArray alloc] init];
                           for (NSDictionary *dic in arr[0]) {
                               if (dic[@"fullname"]) {
                                   [resultArr addObject:dic[@"fullname"]];
                               }
                           }
                           
                           block(YES,resultArr);
                       }
                   }else{
                       block(NO,nil);
                   }
               }];
}

@end
