//
//  DLProvisionAnalyze.h
//  Pods
//
//  Created by ice on 2017/8/3.
//
//

#import <Foundation/Foundation.h>
// 解析mobileProvision证书信息
@interface DLProvisionAnalyze : NSObject

@property (nonatomic,strong) NSString *provisionPath;
@property (nonatomic,strong) NSData *provisionData;

/**
 *  使用证书路径初始化
 *
 */
- (instancetype)initWithPath:(NSString *)path;

/**
 *  使用证书Data初始化
 *
 */
- (instancetype)initWithProvisionData:(NSData *)data;

/**
 *  获取证书信息
 *
 *  @return mobileProvision 证书信息
 */
- (NSDictionary *)getMobileProvision;

/**
 *  获取证书名称
 *
 *  @return mobileProvision 证书名称
 */
- (NSString *)teamName;

/**
 *  获取证书ID
 *
 *  @return mobileProvision 证书ID
 */
- (NSString *)teamID;

/**
 *  获取证书过期时间
 *
 *  @return mobileProvision 证书过期时间
 */
- (NSString *)provisionExpiredTime;

//+ (NSDate *)cerExpireTime;

@end

