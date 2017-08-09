//
//  GYMockRequest+Extended.m
//  Pods
//
//  Created by ice on 2017/8/11.
//
//

#import "GYMockRequest+Extended.h"
#import <objc/message.h>
#import <objc/runtime.h>
#import <GYHttpMock/GYMatcher.h>
#import <GYHttpMock/GYHttpMock.h>

static void *paramsKey = &paramsKey;

@implementation GYMockRequest (Extended)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

- (BOOL)matchesRequest:(id<GYHTTPRequest>)request{
   
    if ([self matchesMethod:request]
        && [self matchesURL:request]
        && [self matchesParams:request]
        && [self matchesBody:request]) {
        return YES;
    }
    
    return NO;
}

#pragma clang diagnostic pop  
/**
 *  判断请求的方法是否相同
 */
- (BOOL)matchesMethod:(id<GYHTTPRequest>)request{
    if (!self.method || [self.method caseInsensitiveCompare:request.method] == NSOrderedSame) {
        return YES;
    }
    return NO;
}

- (BOOL)matchesURL:(id<GYHTTPRequest>)request{
    NSString *url = [self deleteUrlParams:request.url.absoluteString];
    
    NSString *noParamsUrl = [[self deleteUrlParams:self.urlMatcher.string] copy];
    NSDictionary *params = [self paramsWithURL:self.urlMatcher.string];
    // 类别添加属性
    objc_setAssociatedObject(self, paramsKey, params, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    BOOL result = [url hasSuffix:noParamsUrl];
    
    return result;
}

- (BOOL)matchesParams:(id<GYHTTPRequest>)request{
    NSDictionary *params = [self paramsWithURL:request.url.absoluteString];
    NSDictionary *oldParams = objc_getAssociatedObject(self, paramsKey);
    return [self dictionary:params isEqualDictionary:oldParams];
}

- (BOOL)matchesHeaders:(id<GYHTTPRequest>)request{
    for (NSString *header in self.headers) {
        if (![[request.headers objectForKey:header] isEqualToString:[self.headers objectForKey:header]]) {
            return NO;
        }
    }
    
    return YES;
}

/**
 *  仅post才进行判断
 */
- (BOOL)matchesBody:(id<GYHTTPRequest>)request{
    NSData *reqBody = request.body;
    if (!reqBody) {
        return YES;
    }
    
    NSString *reqBodyString = [[NSString alloc] initWithData:reqBody encoding:NSUTF8StringEncoding];
    NSAssert(reqBodyString, @"request body is nil");
    
    NSDictionary *params = [self convertDictionaryWithURLParams:reqBodyString];
    NSDictionary *mockParams =[self jsonFormateToDic:self.body.string];
    return [self dictionary:params isEqualDictionary:mockParams];
}

/**
 *  删除url中的参数
 */
- (NSString *)deleteUrlParams:(NSString *)url{
    NSArray *temp = [url componentsSeparatedByString:@"?"];
    return temp.count == 2 ? temp[0] : url;
}

/**
 *  获取url中的参数
 */
- (NSDictionary *)paramsWithURL:(NSString *)url {
    if (![url isKindOfClass:[NSString class]] || url.length == 0) {
        return nil;
    }
    
    NSArray *urls = [url componentsSeparatedByString:@"?"];
    NSString *paramsURL = nil;
    if (urls.count == 2) {
        paramsURL = urls[1];
    }
    
    return [self convertDictionaryWithURLParams:paramsURL];
}

/**
 *  url 参数转换成字典
 */
- (NSDictionary *)convertDictionaryWithURLParams:(NSString *)paramsURL {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    for (NSString *item in [paramsURL componentsSeparatedByString:@"&"]) {
        NSArray *temp = [item componentsSeparatedByString:@"="];
        if (temp.count == 2) {
            [params setObject:temp[1] forKey:temp[0]];
        }
    }
    
    return params;
    
}

/**
 * 判断两个字典是否相同 只判断key
 */
- (BOOL)dictionary:(NSDictionary *)dic1 isEqualDictionary:(NSDictionary *)dic2 {
    NSSet *setA = [NSSet setWithArray:[dic1 allKeys]];
    NSSet *setB = [NSSet setWithArray:[dic2 allKeys]];
    return [setA isEqualToSet:setB];
}

- (NSDictionary *)jsonFormateToDic:(NSString *)jsonString {
    if (!jsonString) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    if(err) {
#if DEBUG
        NSLog(@"json解析失败：%@",err);
#endif
        return nil;
    }
    
    return dic;
}

@end
