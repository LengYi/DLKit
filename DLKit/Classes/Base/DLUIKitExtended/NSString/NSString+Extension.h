//
//  NSString+Extension.h
//  Pods
//
//  Created by ice on 17/4/24.
//
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

+ (NSString *)stringFromData:(NSData *)data;

+ (NSData *)dataFromHexString:(NSString *)hexString;
+ (NSString *)hexStringFromData:(NSData *)data;

+ (BOOL)isValidEmailString:(NSString *)string;

/**
 * 比较版本号
 *
 * @param v1 第一个版本号
 * @param v2 第二个版本号
 *
 * @return 如果版本号相等，返回 0,
 *         如果第一个版本号低于第二个，返回 -1，否则返回 1.
 */
+ (int)compareVersion:(NSString *)v1 v2:(NSString *)v2;

- (BOOL)isEmail;
- (BOOL)isUrl;
- (BOOL)isTelephoneNumber;

@end
