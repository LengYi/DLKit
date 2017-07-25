//
//  TBViewController.h
//  DLKit
//
//  Created by ice on 2017/7/25.
//  Copyright © 2017年 707689817@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TBViewControllerDelegate;

@interface TBViewController : UIViewController
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,assign) id <TBViewControllerDelegate> tableDelegate;
@end

@protocol TBViewControllerDelegate  <NSObject>
- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end
