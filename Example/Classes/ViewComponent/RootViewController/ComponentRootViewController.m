//
//  ComponentRootViewController.m
//  DLKit
//
//  Created by ice on 2017/8/25.
//  Copyright © 2017年 707689817@qq.com. All rights reserved.
//

#import "ComponentRootViewController.h"
#import "TBViewController.h"
#import "CircleBannerViewController.h"

@interface ComponentRootViewController ()<TBViewControllerDelegate>
@property (nonatomic,strong) TBViewController *tbVC;
@end

@implementation ComponentRootViewController

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
                                     @"ADCircleBannerView",]];
    return dataArray;
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    switch (indexPath.row) {
        case 0:{
            CircleBannerViewController *vc = [[CircleBannerViewController alloc] init];
            [self.navigationController pushViewController:vc animated:NO];
            break;
    }
        default:
            break;
    }
}

@end
