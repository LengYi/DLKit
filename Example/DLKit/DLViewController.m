//
//  DLViewController.m
//  DLKit
//
//  Created by 707689817@qq.com on 03/23/2017.
//  Copyright (c) 2017 707689817@qq.com. All rights reserved.
//

#import "DLViewController.h"
#import "TBViewController.h"
#import "Test_DLHttp.h"
#import "Test_DLAppInfo.h"
#import "Test_DLDocumentPath.h"
#import "Test_DLDownloadFile.h"
#import "Test_DLProtocol.h"
#import "Test_DLKeyChain.h"
#import "Test_DLLog.h"
#import "ExViewController.h"
#import "SafeExViewController.h"
#import "EncryViewController.h"
#import "StatisticViewController.h"

@interface DLViewController ()<TBViewControllerDelegate>
@property (nonatomic,strong) TBViewController *tbVC;
@property (nonatomic,strong) UINavigationController *nav;
@end

@implementation DLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createTableView];
}

- (void)createTableView{
    if (!_tbVC) {
        _tbVC = [[TBViewController alloc] init];
        _tbVC.tableDelegate = self;
        _tbVC.dataArray = [self loadData];
    }
    
    _nav = [[UINavigationController alloc] initWithRootViewController:_tbVC];
    [self.view addSubview:_nav.view];
}

- (NSMutableArray *)loadData{
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    [dataArray addObjectsFromArray:@[@"Http Get Post 网络请求",
                                      @"加解密",
                                      @"App 版本号 sku 名称获取",
                                      @"App document cache tmp 数据存储路径",
                                      @"文件下载器",@"网络数据打包解析",
                                      @"UIKitExtended",
                                      @"UIKitSafeExtended",
                                      @"KeyChain 存储",
                                      @"Log日志",
                                      @"AOP 打点统计"]];
    return dataArray;
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *title = [_tbVC.dataArray objectAtIndex:indexPath.row];
    switch (indexPath.row) {
        case 0:
            [Test_DLHttp test];
            break;
        case 1:{
            EncryViewController *vc = [[EncryViewController alloc] init];
            vc.title = title;
            [_nav pushViewController:vc animated:YES];
            break;
        }
            break;
        case 2:
            [Test_DLAppInfo test];
            break;
        case 3:
            [Test_DLDocumentPath test];
            break;
        case 4:
            [Test_DLDownloadFile test];
            break;
        case 5:
            [Test_DLProtocol test];
            break;
        case 6:{
            ExViewController *vc = [[ExViewController alloc] init];
            vc.title = title;
            [_nav pushViewController:vc animated:YES];
            break;
        }
        case 7:{
            SafeExViewController *vc = [[SafeExViewController alloc] init];
            vc.title = title;
            [_nav pushViewController:vc animated:YES];
            break;
        }
        case 8:
            [Test_DLKeyChain test];
            break;
        case 9:
            [Test_DLLog test];
            break;
        case 10:{
            StatisticViewController *vc = [[StatisticViewController alloc] init];
            vc.title = title;
            [_nav pushViewController:vc animated:NO];
            break;
        }
        default:
            break;
    }
}

@end
