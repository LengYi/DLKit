//
//  NSData+Extended.h
//  GuangdianTong
//
//  Created by ice on 17/2/10.
//  Copyright © 2017年 ice. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Extended)

+ (NSData *)dataFromString:(NSString *)string;
+ (NSData *)dataFromBool:(BOOL)value;
+ (NSData *)dataFromInt:(NSInteger)value;
+ (NSData *)dataFromNumber:(NSNumber *)value;

@end
