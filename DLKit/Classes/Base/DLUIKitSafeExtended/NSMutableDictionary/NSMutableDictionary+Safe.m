//
//  NSMutableDictionary+Safe.m
//  Pods
//
//  Created by ice on 2017/7/24.
//
//

#import "NSMutableDictionary+Safe.h"
#import "NSObject+Swizzle.h"

@implementation NSMutableDictionary (Safe)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       [objc_getClass("__NSDictionaryM") swizzleSelector:@selector(setValue:forKey:) withSwizzledSelector:@selector(safeSetValue:forKey:)];
        [objc_getClass("__NSDictionaryM") swizzleSelector:@selector(setObject:forKey:) withSwizzledSelector:@selector(safeSetObject:forKey:)];
        [objc_getClass("__NSDictionaryM") swizzleSelector:@selector(removeObjectForKey:) withSwizzledSelector:@selector(safeRemoveObjectForKey:)];
    });
}

- (void)safeSetValue:(id)value forKey:(NSString *)key{
    if (key == nil || value == nil || [key isEqual:[NSNull null]] || [value isEqual:[NSNull null]]) {
#if DEBUG
        NSLog(@"%s call -safeSetValue:forKey:, key或vale为nil或null", __FUNCTION__);
#endif
        return;
    }
    
     [self safeSetValue:value forKey:key];
}

- (void)safeSetObject:(id)anObject forKey:(id<NSCopying>)key{
    if (key == nil || anObject == nil || [anObject isEqual:[NSNull null]]) {
#if DEBUG
        NSLog(@"%s call -safeSetObject:forKey:, key或vale为nil或null", __FUNCTION__);
#endif
        return;
    }
    
    [self safeSetObject:anObject forKey:key];
}

- (void)safeRemoveObjectForKey:(id)key{
    if (key == nil || [key isEqual:[NSNull null]] ){
#if DEBUG
        NSLog(@"%s call -safeRemoveObjectForKey:, aKey为nil或null", __FUNCTION__);
#endif
        return;
    }
    
    [self safeRemoveObjectForKey:key];
}
@end
