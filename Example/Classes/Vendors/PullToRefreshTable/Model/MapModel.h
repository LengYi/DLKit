//
//  MapModel.h
//  DLKit
//
//  Created by ice on 2017/11/15.
//  Copyright © 2017年 707689817@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MapModel : NSObject

+ (void)requestCityData:(void(^)(BOOL flag,NSArray *array))block;

@end
