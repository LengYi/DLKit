//
//  DLChineseLog.h
//  Debug
//
//  Created by ice on 2018/1/18.
//  Copyright © 2018年 ice. All rights reserved.
//

#import <Foundation/Foundation.h>

// 解决 NSArray NSDictionary 打印中文无法显示问题,将DLChineseLog.h 包含到项目最顶层的PrefixHeader.pch中即可，无需额外操作。
// PrefixHeader.pch文件如果不存在请自行创建  TARGETS->Build Settings->Prefix Header 工程名称/Supporting Files/PrefixHeader.pch
@interface NSDictionary (Log)

@end
