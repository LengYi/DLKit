//
//  DLMockModel.h
//  Pods
//
//  Created by ice on 2017/8/9.
//
//

#import <Foundation/Foundation.h>

@interface DLMockModel : NSObject

@property (nonatomic,copy) NSString *url;               // 被mock的url
@property (nonatomic,copy) NSString *method;            // GET or POST
@property (nonatomic,copy) NSDictionary *headers;       // 请求头部
@property (nonatomic,copy) NSDictionary *body;          // 请求内容
@property (nonatomic,copy) NSDictionary *response;      // 响应内容
@property (nonatomic, assign) BOOL isMock;              // 是否进行mock操作,默认 NO

@end
