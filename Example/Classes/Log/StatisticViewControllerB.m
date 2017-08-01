//
//  StatisticViewControllerB.m
//  DLKit
//
//  Created by ice on 2017/8/1.
//  Copyright © 2017年 707689817@qq.com. All rights reserved.
//

#import "StatisticViewControllerB.h"
#import "TBViewController.h"
#import "StatisticViewControllerC.h"

@interface StatisticViewControllerB ()<TBViewControllerDelegate>
@property (nonatomic,strong) TBViewController *tbVC;
@end

@implementation StatisticViewControllerB

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self createTableView];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}


- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)createTableView{
    if (!_tbVC) {
        _tbVC = [[TBViewController alloc] init];
        _tbVC.tableDelegate = self;
        _tbVC.dataArray = [self loadData];
        [self.view addSubview:_tbVC.view];
    }
}

- (NSMutableArray *)loadData{
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    [dataArray addObjectsFromArray:@[
                                     @"UIButton+手势事件",
                                     @"单元格选中事件"]];
    return dataArray;
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            StatisticViewControllerC *vc = [[StatisticViewControllerC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

@end
