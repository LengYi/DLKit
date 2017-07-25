//
//  NSMutableArray+Safe.m
//  Pods
//
//  Created by ice on 2017/7/24.
//
//

#import "NSMutableArray+Safe.h"
#import "NSObject+Swizzle.h"

@implementation NSMutableArray (Safe)

+ (void)load{
    // 线程安全控制
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleSelector:@selector(removeObject:) withSwizzledSelector:@selector(safeRemoveObject:)];
        [objc_getClass("__NSArrayM") swizzleSelector:@selector(addObject:) withSwizzledSelector:@selector(safeAddObject:)];
        [objc_getClass("__NSArrayM") swizzleSelector:@selector(removeObjectAtIndex:) withSwizzledSelector:@selector(safeRemoveObjectAtIndex:)];
        [objc_getClass("__NSArrayM") swizzleSelector:@selector(insertObject:atIndex:) withSwizzledSelector:@selector(safeInsertObject:atIndex:)];
        [objc_getClass("__NSPlaceholderArray") swizzleSelector:@selector(initWithObjects:count:) withSwizzledSelector:@selector(safeInitWithObjects:count:)];
        [objc_getClass("__NSArrayM") swizzleSelector:@selector(objectAtIndex:) withSwizzledSelector:@selector(safeObjectAtIndex:)];
    });
}

- (void)safeRemoveObject:(id)obj {
    if (obj == nil) {
#if DEBUG
        NSLog(@"%s call -removeObject:, but argument obj is nil", __FUNCTION__);
#endif
        return;
    }
    [self safeRemoveObject:obj];
}

- (void)safeAddObject:(id)obj {
    if (obj == nil) {
#if DEBUG
        NSLog(@"%s can add nil object into NSMutableArray", __FUNCTION__);
#endif
    } else {
        [self safeAddObject:obj];
    }
}

- (void)safeRemoveObjectAtIndex:(NSUInteger)index {
    if (self.count <= 0) {
#if DEBUG
        NSLog(@"%s can't get any object from an empty array", __FUNCTION__);
#endif
        return;
    }
    if (index >= self.count) {
#if DEBUG
        NSLog(@"%s index out of bound", __FUNCTION__);
#endif
        return;
    }
    [self safeRemoveObjectAtIndex:index];
}

- (void)safeInsertObject:(id)anObject atIndex:(NSUInteger)index {
    if (anObject == nil) {
#if DEBUG
        NSLog(@"%s can't insert nil into NSMutableArray", __FUNCTION__);
#endif
    } else if (index > self.count) {
#if DEBUG
        NSLog(@"%s index is invalid", __FUNCTION__);
#endif
    } else {
        [self safeInsertObject:anObject atIndex:index];
    }
}

- (instancetype)safeInitWithObjects:(const id  _Nonnull     __unsafe_unretained *)objects count:(NSUInteger)cnt
{
    BOOL hasNilObject = NO;
    for (NSUInteger i = 0; i < cnt; i++) {
        if ([objects[i] isKindOfClass:[NSArray class]]) {
#if DEBUG
            NSLog(@"%@", objects[i]);
#endif
        }
        if (objects[i] == nil) {
            hasNilObject = YES;
#if DEBUG
            NSLog(@"%s object at index %lu is nil, it will be     filtered", __FUNCTION__, i);
#endif
        }
    }
    
    // 因为有值为nil的元素，那么我们可以过滤掉值为nil的元素
    if (hasNilObject) {
        id __unsafe_unretained newObjects[cnt];
        NSUInteger index = 0;
        for (NSUInteger i = 0; i < cnt; ++i) {
            if (objects[i] != nil) {
                newObjects[index++] = objects[i];
            }
        }
        return [self safeInitWithObjects:newObjects count:index];
    }
    return [self safeInitWithObjects:objects count:cnt];
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
