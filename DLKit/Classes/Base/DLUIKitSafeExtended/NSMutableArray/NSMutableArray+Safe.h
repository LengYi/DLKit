//
//  NSMutableArray+Safe.h
//  Pods
//
//  Created by ice on 2017/7/24.
//
//

#import <Foundation/Foundation.h>

/**
 *  NSMutableArray 防崩溃模块,使用时只需将改文件添加到当前工程项目即可,无需另外任何操作。
 *  原理: NSMutableArray被使用时系统将自动调用load方法,进而完成方法交换实现防崩溃。
 */
@interface NSMutableArray (Safe)
+ (void)load;
@end
