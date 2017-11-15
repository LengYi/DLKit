//
//  VendorsRootViewController.m
//  DLKit
//
//  Created by ice on 2017/8/28.
//  Copyright © 2017年 707689817@qq.com. All rights reserved.
//

#import "VendorsRootViewController.h"
#import "TBViewController.h"
#import "RefreshTableViewController.h"

@interface VendorsRootViewController ()<TBViewControllerDelegate>
@property (nonatomic,strong) TBViewController *tbVC;
@end

@implementation VendorsRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self createTableView];
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
                                     @"PullToRefreshTable",]];
    return dataArray;
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:{
            RefreshTableViewController *vc = [[RefreshTableViewController alloc] init];
            [self.navigationController pushViewController:vc animated:NO];
            break;
        }
        default:
            break;
    }
}
@end
