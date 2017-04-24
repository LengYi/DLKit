//
//  NSData+Extended.m
//  GuangdianTong
//
//  Created by ice on 17/2/10.
//  Copyright © 2017年 ice. All rights reserved.
//

#import "NSData+Extended.h"

@implementation NSData (Extended)

+ (NSData *)dataFromString:(NSString *)string{
    if (string == nil || ![string isKindOfClass:[NSString class]]) {
        assert(@"参数不是NSStirng类型");
        return nil;
    }
    
    NSData *resultData = [NSData dataWithBytes:[string UTF8String]
                                        length:strlen([string UTF8String])];
    return resultData;
}

+ (NSData *)dataFromBool:(BOOL)value{
    NSString *boolString = [NSString stringWithFormat:@"%d",value];
    return [NSData dataFromString:boolString];
}

+ (NSData *)dataFromInt:(NSInteger)value{
    NSString *intString = [NSString stringWithFormat:@"%ld",(long)value];
    return [NSData dataFromString:intString];
}

+ (NSData *)dataFromNumber:(NSNumber *)value{
    NSString *numberStr = [NSString stringWithFormat:@"%@", value];
    return [NSData dataFromString:numberStr];
}

@end
