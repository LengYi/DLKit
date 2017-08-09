//
//  DLMockManager.h
//  Pods
//
//  Created by ice on 2017/8/9.
//
//

#import <Foundation/Foundation.h>

/**
 *  通过plist文件管理http网络请求，进行假数据回传，对原工程侵入性低，耦合低，易操作管理。
 */
@interface DLMockManager : NSObject

+ (void)configMockWithPlist:(NSString *)fileName;

@end
