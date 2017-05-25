//
//  NSObject+Extension.h
//
//
//

#import <Foundation/Foundation.h>

@interface NSObject (Extension)

// 替换 respondsToSelector 方法
+ (BOOL)validateMethodCanRunWithTarget:(id)target
                           selectorStr:(NSString *)selectorStr;

// 替换 performSelector 方法
- (id)runSelector:(SEL)aSelector
      withObjects:(NSArray *)objects;

@end
