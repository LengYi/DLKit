//
//  ExViewController.m
//  DLKit
//
//  Created by ice on 2017/7/25.
//  Copyright © 2017年 707689817@qq.com. All rights reserved.
//

#import "ExViewController.h"
#import "TBViewController.h"
#import "Test_NSStringEx.h"
#import "Test_NSDataEx.h"
#import "Test_NSURLEx.h"
#import "Test_NSDateEx.h"

@interface ExViewController ()<TBViewControllerDelegate>
@property (nonatomic,strong) TBViewController *tbVC;
@end

@implementation ExViewController

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
                                     @"NSString+Extended",
                                     @"NSData+Extended",
                                     @"NSURL+Extended",
                                     @"NSDate+Extended"]];
    return dataArray;
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            [Test_NSStringEx test];
            break;
        case 1:
            [Test_NSDataEx test];
            break;
        case 2:
            [Test_NSURLEx test];
            break;
        case 3:
             [Test_NSDateEx test];
            break;
        default:
            break;
    }
}
@end
