//
//  Test_DLDownloadFile.m
//  DLKit
//
//  Created by ice on 17/4/20.
//  Copyright © 2017年 707689817@qq.com. All rights reserved.
//

#import "Test_DLDownloadFile.h"
#import "DLDownloadFile.h"
#import "DLDocumentPath.h"

@implementation Test_DLDownloadFile

+ (void)test{
    NSString *path = [DLDocumentPath documentPathWithFileName:@"test.ipa"];
    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    DLDownloadFile *downloadFile = [DLDownloadFile createDownloadFile:@"http://qd.leaderhero.com/qd/tbtui/20170419/tbtui_zb_iPhone_v3.9.3_lrgYA_17041916.ipa"
                                  path:path
                            headerFile:nil
                                  from:0
                                    to:0
                                   pre:^(long long totalSize) {
                                       
                                   } progress:^(long long contentSize, long long receiveSize, long long curReciveSize, NSError *error) {
                                       NSLog(@"已下载 %lld",receiveSize);
                                   } complete:^(long long contentSize, long long receiveSize, long long curReciveSize, NSError *error) {
                                       NSLog(@"下载完成");
                                   } failed:^(long long contentSize, long long receiveSize, long long curReciveSize, NSError *error) {
                                       
                                   }];
    [downloadFile startDownload];
}

@end
