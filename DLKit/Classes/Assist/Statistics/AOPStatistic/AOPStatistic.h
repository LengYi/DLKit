//
//  AOPStatistic.h
//  Pods
//
//  Created by ice on 2017/7/31.
//
//

#import <Foundation/Foundation.h>
#import "DLAspects.h"


typedef NS_ENUM(NSInteger,DLPVSTATUS){
    DL_PV_ENTER = 0,    // 进入页面
    DL_PV_LEAVE         // 离开页面
};

/**
 *  使用方法:
 * 1. 建立一个plist配置文件填写需要统计的页面信息
 * 2. 程序启动时  didFinishLaunchingWithOptions 中调用 [AOPStatistic configDictWithPlistFile:]
 * 3. 建立AOPStatistic类别 AOPStatistic+Handler重载 handlePV:status:  和 handleEvent:EventID: 方法 获取到统计事件
 */

@interface AOPStatistic : NSObject

+ (instancetype)shareInstance;

/**
 *  获取所有统计配置信息
 *
 *  @return 配置信息
 */
+ (NSDictionary *)getConfig;

/**
 *  根据Plist文件获取需要统计的页面信息
 *
 *  @param plistFilePath Plist文件路径
 */
+ (void)configDictWithPlistFile:(NSString *)plistFilePath;

/**
 *  根据JSON文件获取需要统计的页面信息
 *
 *  @param jsonFilePath JSON文件路径
 */
+ (void)configDictWithJsonFile:(NSString *)jsonFilePath;

@end
