//
//  SafeExViewController.m
//  DLKit
//
//  Created by ice on 2017/7/25.
//  Copyright © 2017年 707689817@qq.com. All rights reserved.
//

#import "SafeExViewController.h"
#import "TBViewController.h"
#import "Test_NSArray+Safe.h"
#import "Test_NSMutableArray+Safe.h"
#import "Test_NSMutableDictionAry+Safe.h"

@interface SafeExViewController ()<TBViewControllerDelegate>
@property (nonatomic,strong) TBViewController *tbVC;
@end

@implementation SafeExViewController

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
                                     @"NSArray+Safe",
                                     @"NSMutableArray+Safe",
                                     @"NSMutableDictionary+Safe"]];
    return dataArray;
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            [Test_NSArray_Safe test];
            break;
        case 1:
            [Test_NSMutableArray_Safe test];
            break;
        case 2:
            [Test_NSMutableDictionAry_Safe test];
            break;
        default:
            break;
    }
}

@end
