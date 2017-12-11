//
//  SegmentViewController.m
//  DLKit_Example
//
//  Created by ice on 2017/12/11.
//  Copyright © 2017年 707689817@qq.com. All rights reserved.
//

#import "SegmentViewController.h"
#import "DLSegmentView.h"

@interface SegmentViewController ()

@end

@implementation SegmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 重要
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    NSArray *titleArray = @[@"下载中",@"已下载",@"更新"];
    CGFloat width = titleArray.count * 130;
    
    DLSegmentView *segView = [[DLSegmentView alloc] initWithFrame:CGRectMake(10,100, width, 44)];
   
    [segView showSubView:titleArray
               titleFont:15
        titleNormalColor:[UIColor blackColor]
        titleSelectColor:RGB(0, 155, 235)
                   width:130
               offsetDis:0
          animationImage:[UIImage imageNamed:@"button_selected_animation"]
             selectIndex:0 handle:^(NSInteger selectIndex) {
                 NSLog(@"当前选择位置--%d--",selectIndex);
             }];
    
    segView.backgroundColor = [UIColor redColor];
     [self.view addSubview:segView];
   
}

@end
