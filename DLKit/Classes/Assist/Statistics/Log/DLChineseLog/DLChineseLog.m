//
//  DLChineseLog.m
//  Debug
//
//  Created by ice on 2018/1/18.
//  Copyright © 2018年 ice. All rights reserved.
//

#import "DLChineseLog.h"

@implementation NSDictionary (Log)
- (NSString *)stringByReplaceUnicode{
    NSMutableString *string = [NSMutableString string];
    
    // 开头有个{
    [string appendString:@"{\n"];
    
    // 遍历所有的键值对
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [string appendFormat:@"\t%@", key];
        [string appendString:@" : "];
        [string appendFormat:@"%@,\n", obj];
    }];
    
    // 结尾有个}
    [string appendString:@"}"];
    
    // 查找最后一个逗号
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound)
        [string deleteCharactersInRange:range];
    
    return string;
}

- (NSString *)description{
    return [self stringByReplaceUnicode];
}

- (NSString *)descriptionWithLocale:(id)locale {
    return [self stringByReplaceUnicode];
}

- (NSString *)descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level{
    return [self stringByReplaceUnicode];
}

@end

@implementation NSArray (Log)

- (NSString *)stringByReplaceUnicode{
    NSMutableString *string = [NSMutableString string];
    
    // 开头有个[
    [string appendString:@"[\n"];
    
    // 遍历所有的元素
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [string appendFormat:@"\t%@,\n", obj];
    }];
    
    // 结尾有个]
    [string appendString:@"]"];
    
    // 查找最后一个逗号
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound)
        [string deleteCharactersInRange:range];
    
    return string;
}

- (NSString *)description{
    return [self stringByReplaceUnicode];
}

- (NSString *)descriptionWithLocale:(id)locale {
    return [self stringByReplaceUnicode];
}

- (NSString *)descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level{
    return [self stringByReplaceUnicode];
}

@end
