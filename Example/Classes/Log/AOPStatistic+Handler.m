//
//  AOPStatistic+Handler.m
//  DLKit
//
//  Created by ice on 2017/8/1.
//  Copyright © 2017年 707689817@qq.com. All rights reserved.
//

#import "AOPStatistic+Handler.h"

@implementation AOPStatistic (Handler)

+ (void)handlePV:(id<DLAspectInfo>)data status:(DLPVSTATUS)status callBackDic:(NSDictionary *)callBackDic{
    NSString *vcName = NSStringFromClass([[data instance] class]);
 
    if (status == DL_PV_ENTER) {
        NSLog(@"进入  %@ 页面 ==>, %@",vcName,callBackDic);
    }else{
        NSLog(@"离开  %@ 页面 ==>, %@",vcName,callBackDic);
    }
}

+ (void)handleEvent:(id<DLAspectInfo>)data EventID:(NSInteger)eventId callBackDic:(NSDictionary *)callBackDic{
    NSArray *array = [[data originalInvocation] aspects_arguments];
    NSLog(@"EventID:%d, argumentArray: = %@, %@",eventId,array,callBackDic);
    
    NSInteger methodID = [[[callBackDic allKeys] objectAtIndex:0] integerValue];
    
    if (eventId == 1000) {
        NSIndexPath *indexPatch = [array objectAtIndex:0];
        NSString *cellTitle = [[data instance] valueForKeyPath:@"tbVC.dataArray"][indexPatch.row];
        NSLog(@"点击了第 %u 行 cellTitle = %@ ",indexPatch.row,cellTitle);
    }else if (eventId == 3000){
        if (methodID == 3001) {
            NSLog(@"统计 StatisticViewControllerC--->button0ClickAction 事件");
        }else if(methodID == 3002){
            NSLog(@"统计 StatisticViewControllerC--->button1ClickAction 事件");
        }else if(methodID == 3003){
            NSLog(@"统计 StatisticViewControllerC--->tapAction 事件");
        }
    }
}

@end
