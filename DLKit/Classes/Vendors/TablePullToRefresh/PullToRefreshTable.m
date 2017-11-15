//
//  PullToRefreshTable.m
//  Pods
//
//  Created by ice on 2017/8/25.
//
//

#import "PullToRefreshTable.h"

@implementation PullToRefreshTable
- (void)installPullAction:(BOOL)downToUp{
    __weak typeof(PullToRefreshTable) *weakSelf= self;
    [self addPullToRefreshWithActionHandler:^{
        // 顶部下拉刷新
        [weakSelf pullAction:positionTopRefreshToDown];
    }];
    
    if(downToUp){
        [self addInfiniteScrollingWithActionHandler:^{
            // 底部上拉刷新
            [weakSelf pullAction:positionDownRefreshToUp];
        }];
    }
    
    [self customPullTitle];
}

- (void)pullAction:(TableRefreshType)refreshType{
    if (self.pullToRefreshTableDelegate && [self.pullToRefreshTableDelegate respondsToSelector:@selector(tableView:reloadWithRefreshType:)]) {
        [self.pullToRefreshTableDelegate tableView:self reloadWithRefreshType:refreshType];
    }
}

// 自定义下拉刷新标题
- (void)customPullTitle{
    [self.pullToRefreshView setTitle:@"下拉即可刷新" forState:SVPullToRefreshStateStopped];
    [self.pullToRefreshView setTitle:@"松开立即更新" forState:SVPullToRefreshStateTriggered];
    [self.pullToRefreshView setTitle:@"正在加载中..." forState:SVPullToRefreshStateLoading];
}

@end
