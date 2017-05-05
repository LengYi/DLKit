//
//  Test_DLKeyChain.m
//  DLKit
//
//  Created by ice on 17/5/5.
//  Copyright © 2017年 707689817@qq.com. All rights reserved.
//

#import "Test_DLKeyChain.h"
#import "DLKeyChain.h"

#define KEY_PASSWORD @"com.dl.app.password"
#define KEY_USERNAME_PASSWORD @"com.dl.app.usernamepassword"

@implementation Test_DLKeyChain

+ (void)test{
    // 将数据存储到keyChain中
    NSDictionary *dataDic = @{@"mmmm" : KEY_PASSWORD};
    [DLKeyChain saveDataWithKeyChain:dataDic forKey:KEY_USERNAME_PASSWORD];
    
    // 取出存储到keyChain中的数据
    NSLog(@"读取存储结果 %@",[DLKeyChain loadDataWithKeyChain:KEY_USERNAME_PASSWORD]);
    
    // 删除存储到keyChain中的数据
    [DLKeyChain deleteDataWithKeyChain:KEY_USERNAME_PASSWORD];
}
@end
