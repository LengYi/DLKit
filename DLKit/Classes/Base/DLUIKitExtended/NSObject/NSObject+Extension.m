//
//  NSObject+Extension.m
//
//
//

#import "NSObject+Extension.h"
#import <objc/runtime.h>

@implementation NSObject (Extension)

+ (BOOL)validateMethodCanRunWithTarget:(id)target selectorStr:(NSString *)selectorStr{
    unsigned int methodCount = 0;
    Method* methodList = class_copyMethodList([target class],&methodCount);
    NSMutableArray *methodsArray = [NSMutableArray arrayWithCapacity:methodCount];
    
    for(int i=0;i<methodCount;i++)
    {
        Method temp = methodList[i];
        IMP imp = method_getImplementation(temp);
        SEL name_f = method_getName(temp);
        const char* name_s =sel_getName(method_getName(temp));
        int arguments = method_getNumberOfArguments(temp);
        const char* encoding =method_getTypeEncoding(temp);
        NSLog(@"方法名：%@,参数个数：%d,编码方式：%@",[NSString stringWithUTF8String:name_s],
              arguments,
              [NSString stringWithUTF8String:encoding]);
        [methodsArray addObject:[NSString stringWithUTF8String:name_s]];
    }
    free(methodList);
    for (NSString *methodStr   in [methodsArray copy]) {
        if ([methodStr isEqualToString:selectorStr]) {
            
            return YES;
            break;
        }
    }
    
    return NO;
}

- (id)runSelector:(SEL)aSelector withObjects:(NSArray *)objects{
    NSMethodSignature *signature = [self methodSignatureForSelector:aSelector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:self];
    [invocation setSelector:aSelector];
    
    NSUInteger i = 1;
    for (id obj in objects) {
        id tempObject = obj;
        [invocation setArgument:&tempObject atIndex:++i];
    }
    
    [invocation invoke];
    
    if ([signature methodReturnLength]) {
        id data;
        [invocation getReturnValue:&data];
        return data;
    }
    
    return nil;
}

@end
