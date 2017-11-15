//
//  RefreshTableViewController.m
//  DLKit
//
//  Created by ice on 2017/8/28.
//  Copyright © 2017年 707689817@qq.com. All rights reserved.
//

#import "RefreshTableViewController.h"
#import "PullToRefreshTable.h"
#import "BaseViewController+CaptionView.h"
#import "BaseViewController+LoadingView.h"
#import "MapModel.h"

@interface RefreshTableViewController ()<PullToRefreshTableDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) PullToRefreshTable *table;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation RefreshTableViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.view addSubview:self.table];
    
    [self.table installPullAction:YES];
    
    [self requestData];
}

- (PullToRefreshTable *)table{
    if (!_table) {
        _table = [[PullToRefreshTable alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 64) style:UITableViewStylePlain];
        _table.pullToRefreshTableDelegate = self;
        _table.delegate = self;
        _table.dataSource = self;
    }
    return _table;
}

- (void)requestData{
    [self removeCaptionView];
    [self addLoadingView];
    
    WS(weakSelf);
    [MapModel requestCityData:^(BOOL flag, NSArray *array) {
        [weakSelf stopUpToDown];
        [self removeLoadingView];
        
        if (flag && array) {
            [_dataArray addObjectsFromArray:array];
            [self.table reloadData];
        }else{
            [self addCaptionView];
        }
    }];
}

#pragma UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"identify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    
    cell.textLabel.text = _dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - PullToRefreshTableDelegate
- (void)tableView:(UITableView *)tableView reloadWithRefreshType:(TableRefreshType)refreshType{
    if (refreshType == positionTopRefreshToDown) {
        NSLog(@"顶部下拉刷新,3秒后动画结束");
        [self requestData];
        //[self performSelector:@selector(stopUpToDown) withObject:nil afterDelay:3];
    }else if(refreshType == positionDownRefreshToUp){
        NSLog(@"底部上拉刷新,3秒后动画结束");
        [self performSelector:@selector(stopDownToUp) withObject:nil afterDelay:3];
    }
}

- (void)stopUpToDown{
    [self.table.pullToRefreshView stopAnimating];
    self.table.showsInfiniteScrolling = YES;
}

- (void)stopDownToUp{
    self.table.showsInfiniteScrolling = NO;
    [self.table.infiniteScrollingView stopAnimating];
}

// 重新发送网络请求
- (void)reachabilityChanged:(ABNetworkStatus)status{
    if (status != ABNotReachable) {
        NSLog(@"无网络->有网络重新发起请求");
        [self requestData];
    }else{
        NSLog(@"无网络");
    }
}

- (void)captionViewClickAction{
    [self requestData];
}

@end
