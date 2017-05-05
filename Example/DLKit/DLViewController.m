//
//  DLViewController.m
//  DLKit
//
//  Created by 707689817@qq.com on 03/23/2017.
//  Copyright (c) 2017 707689817@qq.com. All rights reserved.
//

#import "DLViewController.h"
#import "Test_DLHttp.h"
#import "Test_DLDESBase64.h"
#import "Test_DLAppInfo.h"
#import "Test_DLDocumentPath.h"
#import "Test_DLDownloadFile.h"
#import "Test_NSStringEx.h"
#import "Test_NSDataEx.h"
#import "Test_DLProtocol.h"
#import "Test_DLKeyChain.h"

@interface DLViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation DLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self loadData];
    [self createTableView];    
}

- (void)createTableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
}

- (void)loadData{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    
    [_dataArray addObjectsFromArray:@[@"Htpp Get Post 网络请求",@"DESBase64 加解密",@"App 版本号 sku 名称获取",@"App document cache tmp 数据存储路径",@"文件下载器",@"网络数据打包解析",@"NSString+Extended",@"NSData+Extended",@"KeyChain 存储"]];
}

#pragma  mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"iden";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    
    cell.textLabel.text = [_dataArray objectAtIndex:indexPath.row];
    return cell;
}
#pragma  mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            [Test_DLHttp test];
            break;
        case 1:
            [Test_DLDESBase64 test];
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
        case 6:
            [Test_NSStringEx test];
            break;
        case 7:
            [Test_NSDataEx test];
            break;
        case 8:
            [Test_DLKeyChain test];
            break;
        default:
            break;
    }
}

@end
