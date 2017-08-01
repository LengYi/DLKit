//
//  StatisticViewController.m
//  DLKit
//
//  Created by ice on 2017/8/1.
//  Copyright © 2017年 707689817@qq.com. All rights reserved.
//

#import "StatisticViewController.h"
#import "StatisticViewControllerA.h"
#import "StatisticViewControllerB.h"
#import "AOPStatistic.h"

@interface StatisticViewController ()

@end

@implementation StatisticViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [AOPStatistic configDictWithPlistFile:@"Stastic"];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(50, 100, 100, 30);
    
    button.tag = 100;
    [button setTitle:@"页面统计" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    button1.frame = CGRectMake(200, 100, 100, 30);
    button1.tag = 200;
    [button1 setTitle:@"事件统计" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
}

- (void)buttonClickAction:(UIButton *)btn{
    if (btn.tag == 100) {
        StatisticViewControllerA *vc = [[StatisticViewControllerA alloc] init];
        vc.title = btn.currentTitle;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        StatisticViewControllerB *vc = [[StatisticViewControllerB alloc] init];
        vc.title = btn.currentTitle;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
