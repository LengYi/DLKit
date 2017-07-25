//
//  NSArray+Safe.m
//  Pods
//
//  Created by ice on 2017/7/24.
//
//

#import "NSArray+Safe.h"
#import "NSObject+Swizzle.h"

@implementation NSArray (Safe)

+ (void)load{
    // 线程安全控制
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [objc_getClass("__NSArrayI") swizzleSelector:@selector(objectAtIndex:) withSwizzledSelector:@selector(safeObjectAtIndex:)];
    });
}

- (id)safeObjectAtIndex:(NSUInteger)index {
    if (self.count == 0) {
#if DEBUG
        NSLog(@"%s can't get any object from an empty array", __FUNCTION__);
#endif
        return nil;
    }
    if (index >= self.count) {
#if DEBUG
        NSLog(@"%s index out of bounds in array", __FUNCTION__);
#endif
        return nil;
    }
    return [self safeObjectAtIndex:index];
}

@end
