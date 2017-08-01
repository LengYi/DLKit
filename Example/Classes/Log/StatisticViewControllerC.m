//
//  StatisticViewControllerC.m
//  DLKit
//
//  Created by ice on 2017/8/1.
//  Copyright © 2017年 707689817@qq.com. All rights reserved.
//

#import "StatisticViewControllerC.h"

@interface StatisticViewControllerC ()

@end

@implementation StatisticViewControllerC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button0 = [UIButton buttonWithType:UIButtonTypeSystem];
    button0.frame = CGRectMake(0, 0, 100, 30);
    button0.center = CGPointMake(self.view.center.x - 100, self.view.center.y - 50);
    
    [button0 setTitle:@"Button click0" forState:UIControlStateNormal];
    [button0 addTarget:self action:@selector(button0ClickAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button0];
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    button1.frame = CGRectMake(0, 0, 100, 30);
    button1.center = CGPointMake(self.view.center.x + 50, self.view.center.y - 50);
    
    [button1 setTitle:@"Button click1" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(button1ClickAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];

    
    UILabel *tapLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    tapLabel.center = CGPointMake(self.view.center.x, self.view.center.y + 50);
    tapLabel.text = @"Tap 手势";
    tapLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [tapLabel addGestureRecognizer:tap];
    [self.view addSubview:tapLabel];
}

- (void)button0ClickAction{
    NSLog(@"button0ClickAction");
}

- (void)button1ClickAction{
    NSLog(@"button1ClickAction");
}

- (void)tapAction{
    NSLog(@"tapAction");
}

@end
