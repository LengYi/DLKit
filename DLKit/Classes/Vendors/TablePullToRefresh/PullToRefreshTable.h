//
//  PullToRefreshTable.h
//  Pods
//
//  Created by ice on 2017/8/25.
//
//

#import <UIKit/UIKit.h>
#import <SVPullToRefresh/SVPullToRefresh.h>

/** 表格下拉上拉组件*/
typedef enum Refresh {
    positionTopRefreshToDown,       // 顶部下拉刷新
    positionDownRefreshToUp         // 底部上拉刷新
}TableRefreshType;

@protocol PullToRefreshTableDelegate;

@interface PullToRefreshTable:UITableView

@property (nonatomic,assign) id <PullToRefreshTableDelegate> pullToRefreshTableDelegate;
/**
 安装下拉刷新和上拉刷新动作，默认安装下拉刷新
 @param downToUp 是否安装上拉刷新动作
 */
- (void)installPullAction:(BOOL)downToUp;

@end


@protocol PullToRefreshTableDelegate <NSObject>

/**
 下拉上拉动作事件回调
 @param tableView 表格对象
 @param refreshType 刷新类型 下拉还是上拉
 */
@optional
- (void)tableView:(UITableView *)tableView reloadWithRefreshType:(TableRefreshType)refreshType;

@end
