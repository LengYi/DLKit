//
//  MockViewController.m
//  DLKit
//
//  Created by ice on 2017/8/11.
//  Copyright © 2017年 707689817@qq.com. All rights reserved.
//

#import "MockViewController.h"
#import "DLHttp.h"
#import "TBViewController.h"
#import "DLMockManager.h"

@interface MockViewController ()<TBViewControllerDelegate>
@property (nonatomic,strong) TBViewController *tbVC;
@end

@implementation MockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self createTableView];
    
    [DLMockManager configMockWithPlist:@"RequestMock.plist"];
}

- (void)createTableView{
    if (!_tbVC) {
        _tbVC = [[TBViewController alloc] init];
        _tbVC.tableDelegate = self;
        _tbVC.dataArray = [self loadData];
    }
    
    [self.view addSubview:_tbVC.view];
}

- (NSMutableArray *)loadData{
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    [dataArray addObjectsFromArray:@[@"GET",@"POST"]];
    return dataArray;
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0://GET
        {
            NSString *url = @"http://data.idown.hk/tuiexe/sku.aspx";
            [DLHttp asynWithGetURLString:url
                         withHeaderField:nil
                     withTimeoutInterval:0
                          withForeground:YES
                            shouldEncode:YES
                       completionHandler:^(NSData *data, NSError *error, NSHTTPURLResponse *response) {
                           NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                           NSLog(@"resultDic = %@",resultDic);
                       }];
        }
            break;
        case 1://POST
        {
            NSString *url = @"https://www.baidu.com/china/abc.php";
            
            NSString *postString = [NSString stringWithFormat:@"age=22&name=122&sex=dd"];
            NSData *postData = [NSData dataWithBytes:[postString UTF8String] length:[postString length]];

            [DLHttp asynWithPostURLString:url
                                 withData:postData
                          withHeaderField:nil
                      withTimeoutInterval:0
                           withForeground:YES
                          shouldUrlEncode:NO
                        completionHandler:^(NSData *data, NSError *error, NSHTTPURLResponse *response) {
                            NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                            NSLog(@"resultDic = %@",resultDic);
                        }];
        }

            break;
        default:
            break;
    }
}

@end
