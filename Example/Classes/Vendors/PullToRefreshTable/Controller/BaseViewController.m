//
//  BaseViewController.m
//  DLKit
//
//  Created by ice on 2017/11/15.
//  Copyright © 2017年 707689817@qq.com. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<NetReachabilityDelegate>
@property (nonatomic,strong) NetReachability *reachability;
@end

@implementation BaseViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        _reachability = [[NetReachability alloc] initWithDefaultRoute:YES];
        _reachability.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

#pragma mark - NetReachabilityDelegate
- (void)reachabilityDidUpdate:(NetReachability*)reachability reachable:(BOOL)reachable usingCell:(BOOL)usingCell{
    ABNetworkStatus netStatus;
    if (reachable){
        if (usingCell){
            netStatus = ABReachableViaWWAN;
        }
        else{
            netStatus = ABReachableViaWiFi;
        }
    }
    else{
        netStatus = ABNotReachable;
    }
    
    [self reachabilityChanged:netStatus];
    
}

- (void)reachabilityChanged:(ABNetworkStatus)status{
    
}

@end
