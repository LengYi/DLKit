//
//  ADCircleBannerView.m
//
//  Created by ice on 15/10/19.
//  Copyright (c) 2015年 tongbu. All rights reserved.
//

#import "ADCircleBannerView.h"

@interface ADCircleBannerView()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView   *scrollView;
@property (nonatomic,assign) NSInteger      totalPages;
@property (nonatomic,strong) NSMutableArray *viewsArray;
@property (nonatomic,strong) NSTimer        *timer;
@end

@implementation ADCircleBannerView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _autoLoop = YES;
        _totalPages     =   0;
        _viewsArray     =   [[NSMutableArray alloc] init];
        self.animationInterval = 3;
        
        _backgroundImaegView = [[UIImageView alloc] initWithFrame:frame];
        [self addSubview:_backgroundImaegView];
     
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _scrollView.contentSize = CGSizeMake(frame.size.width,frame.size.height);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.clipsToBounds = NO;     // 所在的父类该属性必须为NO
        [self addSubview:_scrollView];

        CGRect rect = CGRectMake(0, frame.size.height - 26, frame.size.width, 25);
        _pageControl = [[SMPageControl alloc] initWithFrame:rect];
        _pageControl.hidesForSinglePage = YES;
        _pageControl.currentPage = 0;
        [_pageControl addTarget:self action:@selector(pageControlSelectAction) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_pageControl];
    }
    return self;
}

- (void)setDataSource:(id<ADCircleBannerViewDataSource>)dataSource{
    _dataSource = dataSource;
    [self reloadData];
}

- (void)setAnimationInterval:(NSTimeInterval)animationInterval{
    
    if(!self.autoLoop) return;
    
    _animationInterval = animationInterval;
    if (_timer) {
        [_timer invalidate];
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:self.animationInterval
                                              target:self
                                            selector:@selector(animationTimerDidFired:)
                                            userInfo:nil
                                             repeats:YES];
}

- (void)reloadData{
    self.totalPages = [_dataSource numberOfPagesADCircleBannerView:self];
    if (self.totalPages == 0) {
        return;
    }
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = self.totalPages;
    
    if (self.totalPages > 1) {
        _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * (4 + self.totalPages), _scrollView.frame.size.height);
        
    }else{
        _scrollView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    }
    
    [self loadData];
}

// 算法  数组: 0 1 2 变成 1 2 0 1 2 0 1 进行循环
- (void)loadData{
    
    // 移除所有scrollView上的视图
    NSArray *subViews = [_scrollView subviews];
    if (subViews && [subViews count]) {
        [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    if (self.viewsArray.count > 0) {
        [self.viewsArray removeAllObjects];
    }
    
    if (self.totalPages == 1) {
         UIView *normalView = [self.dataSource adBannerView:self pageAtIndex:0];
         normalView.tag = 1000;
        NSAssert(normalView != nil, @"view can not be nil!");
        [self.viewsArray addObject:normalView];
    }else if(self.totalPages >= 2){
    
        // 取倒数第2个数据,加载到最前面一页
        NSInteger prePage0 = self.totalPages - 2;
        UIView *preView0 = [self.dataSource adBannerView:self pageAtIndex:prePage0];
        preView0.tag = 1000 + prePage0;
        NSAssert(preView0 != nil, @"view can not be nil!");
        [self.viewsArray addObject:preView0];
        
        // 取最后一个数据,加载最前面一页
        NSInteger prePage1 = self.totalPages - 1;
        UIView *preView1 = [self.dataSource adBannerView:self pageAtIndex:prePage1];
        preView1.tag = 1000 + prePage1;
        NSAssert(preView1 != nil, @"view can not be nil!");
        [self.viewsArray addObject:preView1];
        
        // 加载中间正常页
        for (int i = 0; i < self.totalPages; i++) {
            UIView *normalView = [self.dataSource adBannerView:self pageAtIndex:i];
            normalView.tag = 1000 + i;
            NSAssert(normalView != nil, @"view can not be nil!");
            [self.viewsArray addObject:normalView];
        }
        
        // 取第一个数据,加载倒数第二页
        NSInteger lastPage0 = 0;
        UIView *lastView0 = [self.dataSource adBannerView:self pageAtIndex:lastPage0];
        lastView0.tag = 1000;
        NSAssert(lastView0 != nil, @"view can not be nil!");
        [self.viewsArray addObject:lastView0];
        
        // 取第二个数据,加载倒数第一页
        NSInteger lastPage1 = 1;
        UIView *lastView1 = [self.dataSource adBannerView:self pageAtIndex:lastPage1];
        lastView1.tag = 1000;
        NSAssert(lastView1 != nil, @"view can not be nil!");
        [self.viewsArray addObject:lastView1];
        
        // 加载完数据,滚动到展示的第一页,实际的第2页
        [_scrollView setContentOffset:CGPointMake(self.frame.size.width * 2, 0)];
    }
    
    for (int i = 0; i < self.viewsArray.count; i++) {
        UIView *view = [self.viewsArray objectAtIndex:i];
        
        view.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [view addGestureRecognizer:tapRecognizer];
        view.frame = CGRectOffset(view.frame, view.frame.size.width * i, 0);
        
        [self.scrollView addSubview:view];
    }
    
    self.pageControl.currentPage = 0;
}

- (void)handleTap:(UITapGestureRecognizer *)tap{
    NSInteger index = tap.view.tag - 1000;
    if (self.delegate && [self.delegate respondsToSelector:@selector(circleBannerView:didClickPageIndex:)]) {
        [self.delegate circleBannerView:self didClickPageIndex:index];
    }
}

- (void)pageControlSelectAction{
    [self pause];
    
    float offsetX = self.scrollView.contentOffset.x;
    float width = self.scrollView.frame.size.width;
    
    BOOL animation = YES;
    if (offsetX >= width * (self.viewsArray.count - 2)){
        animation = NO;
    }else if(offsetX <= width){
        animation = NO;
    }
    
    NSInteger currentPage = self.pageControl.currentPage;
    offsetX = (currentPage + 2) * self.scrollView.frame.size.width;
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:animation];
    
    [self performSelector:@selector(resume) withObject:nil afterDelay:3];
}

- (void)changeScrollViewOffset:(UIScrollView *)scrollView autoChange:(BOOL)autoFlag{
    
    float offsetX = scrollView.contentOffset.x;
    float width = scrollView.frame.size.width;
    
    BOOL animation = NO;
    NSInteger currentPage = -1;

        if (offsetX >= width * (self.viewsArray.count - 2)) {
            offsetX = width * 2;   // 回到实际的第2页，显示的第1页
            currentPage = 0;
        }else if(offsetX <= width){
            offsetX = width * (2 + (self.totalPages - 1)); //最前面两页 + 倒数第2页
            currentPage = self.totalPages;
        }else{
            if (autoFlag) {
                offsetX += width;
                animation = YES;
            }
   
            currentPage = floor((CGFloat)(offsetX - width / 2) / (CGFloat)width) - 1;
            if(currentPage >= self.totalPages){
                currentPage = 0;
                animation = NO;
                offsetX = width * 2;
            }
        }
    self.pageControl.currentPage = currentPage;
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:animation];
}

#pragma mark - 定时器
- (void)animationTimerDidFired:(NSTimer *)timer{
    if (self.totalPages == 1) {
        return;
    }
    
    [self changeScrollViewOffset:self.scrollView autoChange:YES];
}

// 暂停定时器
- (void)pause{
    if (!_autoLoop) return;
    
    if (![self.timer isValid]) {
        return;
    }
    
    [self.timer setFireDate:[NSDate distantFuture]];
}

// 恢复定时器
- (void)resume{
    if (!_autoLoop) return;
    [self resumeTimerAfterTimeInterval:self.animationInterval];
    
}

- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval
{
    if (self.totalPages == 1) {
        return;
    }
    
    if (![self.timer isValid]) {
        return ;
    }
    [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self pause];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self changeScrollViewOffset:scrollView autoChange:NO];
    [self resume];
}

@end
