//
//  DLMockManager.m
//  Pods
//
//  Created by ice on 2017/8/9.
//
//

#import "DLMockManager.h"
#import "DLMockModel.h"
#import <objc/runtime.h>

#import <GYHttpMock/GYMockRequestDSL.h>
#import <GYHttpMock/GYMockResponseDSL.h>

@interface DLMockManager ()
@property (nonatomic,strong) NSSet <DLMockModel *> *requestSets;
@end

@implementation DLMockManager

+ (instancetype)shareInstance{
    static DLMockManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [[DLMockManager alloc] init];
        }
    });
    return manager;
}

+ (void)configMockWithPlist:(NSString *)fileName{
    NSString *suffix = [fileName pathExtension];
    if ([suffix isEqualToString:@"plist"]||[suffix isEqualToString:@""]) {
        NSString *correctFileName = [fileName stringByDeletingPathExtension];
        suffix =suffix ?@"plist":nil;
        NSString *filePath = [[NSBundle mainBundle] pathForResource:correctFileName ofType:suffix];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        NSArray *array = [dic allValues];
        
        // 配置mock数据
        [self configRequestSet:array];
        // 开始mock请求处理
        [[DLMockManager shareInstance] gotoMockRequest];
    }else{
        NSAssert(suffix, @"the config file type should be plist");
    }
}

+ (void)configRequestSet:(NSArray *)array{
    if (array && [array isKindOfClass:[NSArray class]]){
        NSMutableArray *tmpArr = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in array){
            DLMockModel *model = [[DLMockModel alloc] init];
            unsigned int outCount;
            // 读取属性列表项
            objc_property_t *properties = class_copyPropertyList([DLMockModel class], &outCount);
            for (int i = 0; i < outCount; i++) {
                objc_property_t property = properties[i];
                const char *char_f = property_getName(property);
                NSString *propertyName = [NSString stringWithUTF8String:char_f];
                id propertyValue = [dic valueForKey:(NSString *)propertyName];
                if ([DLMockManager isValidObject:propertyValue]) {
                    [model setValue:propertyValue forKey:propertyName];
                    [tmpArr addObject:model];
                }
            }
            free(properties);
        }
        
        [DLMockManager shareInstance].requestSets = [NSSet setWithArray:[tmpArr copy]];
    }
}

+ (BOOL)isValidObject:(id)obj{
    if ([obj isEqual:[NSNull null]]) {
        return NO;
    }
    if ([obj isKindOfClass:[NSString class]]) {
        if ([(NSString *)obj isEqualToString:@""]) {
            return NO;
        }
        return YES;
    }
    
    if (!obj) {
        return NO;
    }
    return YES;
}

- (void)gotoMockRequest{
    for (DLMockModel *model in self.requestSets) {
        // 不需要mock则跳过继续
        if (!model.isMock) {
            continue;
        }
        
        NSString *bodyStr = nil;
        if (model.body && [model.body isKindOfClass:[NSDictionary class]]) {
            bodyStr = [self formateToJson:model.body];
        }
        
        NSString *response = nil;
        if (model.response && [model.response isKindOfClass:[NSDictionary class]]) {
            response = [self formateToJson:model.response];
        }
        
        if ([model.method caseInsensitiveCompare:@"GET"] == NSOrderedSame) {
            mockRequest(@"GET", model.url).andReturn(200).withBody(response);
        }else if([model.method caseInsensitiveCompare:@"POST"] == NSOrderedSame){
            mockRequest(@"POST", model.url).withBody(bodyStr).withHeaders(model.headers).andReturn(200).withBody(response);
        }
    }
}

- (NSString *)formateToJson:(id)obj{
    NSString *jsonStr = nil;
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (!jsonData) {
#if DEBUG
        NSLog(@"formateToJson --> error: %@", error);
#endif
    }else{
        jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    return jsonStr;
}
@end
