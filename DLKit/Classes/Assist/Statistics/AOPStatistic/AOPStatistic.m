//
//  AOPStatistic.m
//  Pods
//
//  Created by ice on 2017/7/31.
//
//

#import "AOPStatistic.h"

NSString const *DLPVKey         =   @"PV";
NSString const *DLEventIDKey    =   @"EventID";
NSString const *DLEventKey      =   @"Event";
NSString const *DLConfigKey     =   @"EventConfig";
NSString const *DLSelectorKey   =   @"Selector";
NSString const *DLTargetKey     =   @"Target";

@interface AOPStatistic ()

@property (nonatomic,strong) NSDictionary *configDict;   // 统计页面配置信息

@end

@implementation AOPStatistic

#pragma mark - PublicMethod
+ (instancetype)shareInstance{
    static AOPStatistic *statistic = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!statistic) {
            statistic = [[AOPStatistic alloc] init];
        }
    });
    
    return statistic;
}

+ (void)configDictWithPlistFile:(NSString *)plistFilePath{
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]
                                                                    pathForResource:plistFilePath
                                                                    ofType:@"plist"]];
    if (dic) {
        [[AOPStatistic shareInstance] setConfigDict:dic];
        [AOPStatistic setUp];
    }else{
#ifdef DEBUG
        NSLog(@"数据载入异常 plistFilePath = %@",plistFilePath);
#endif
    }
}

+ (void)configDictWithJsonFile:(NSString *)jsonFilePath{
    NSData *data = [NSData dataWithContentsOfFile:jsonFilePath];
    if (data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        if (dic) {
            [[AOPStatistic shareInstance] setConfigDict:dic];
            [AOPStatistic setUp];
        }else{
#ifdef DEBUG
            NSLog(@"NSData->JSON 数据转换失败,JSON格式异常");
#endif
        }
    }else{
#ifdef DEBUG
        NSLog(@"数据载入异常 jsonFilePath = %@",jsonFilePath);
#endif
    }
}

+ (NSDictionary *)getConfig{
    return [AOPStatistic shareInstance].configDict;
}

#pragma mark - CoverMethod
/**
 *  PV 事件处理接口,外部通过类别重载覆盖当前方法进行处理
 *
 *  @param data   被处理的数据对象及方法、参数
 *  @param status 页面状态 离开还是进入
 *  @param callBackDic  返回配置原始数据,可以添加任何数据,例如 添加PVID 用于判断不同页面
 */
+ (void)handlePV:(id<DLAspectInfo>)data status:(DLPVSTATUS)status callBackDic:(NSDictionary *)callBackDic{
    
}

/**
 *  统计事件处理接口,外部通过类别重载覆盖当前方法进行处理
 *
 *  @param data    被处理的数据对象及方法、参数
 *  @param eventId 页面事件ID
 *  @param callBackDic  返回配置原始数据,可以添加任何数据,例如 添加MethodID 用于判断不同的方法
 */
+ (void)handleEvent:(id<DLAspectInfo>)data EventID:(NSInteger)eventId callBackDic:(NSDictionary *)callBackDic{
    
}

#pragma mark - PrivateMethod
+ (void)setUp{
    [AOPStatistic configPV];
    [AOPStatistic configEvents];
}

+ (void)configPV{
    NSDictionary *pvDic = [AOPStatistic shareInstance].configDict[DLPVKey];
    for (NSString *vcName in [pvDic allKeys]) {
        Class target = NSClassFromString(vcName);
        NSDictionary *dic = pvDic[vcName];
        
        if (target) {
            [target aspect_hookSelector:@selector(viewDidAppear:)
                            withOptions:DLAspectPositionAfter
                             usingBlock:^(id data){
                                 [AOPStatistic handlePV:data status:DL_PV_ENTER callBackDic:dic];
                             }error:nil];
            
            [target aspect_hookSelector:@selector(viewDidDisappear:)
                            withOptions:DLAspectPositionAfter
                             usingBlock:^(id data){
                                 [AOPStatistic handlePV:data status:DL_PV_LEAVE callBackDic:dic];
                             }error:nil];
        }else{
#ifdef DEBUG
            NSLog(@"target 异常");
#endif
        }
    }
}

+ (void)configEvents{
    NSDictionary *eventsDic = [AOPStatistic shareInstance].configDict[DLEventKey];
    NSArray *events = [eventsDic allValues];
    for (NSDictionary *dic in events) {
        NSString *eventIDStr = dic[DLEventIDKey];
        NSInteger EventID = -1;
        if (eventIDStr) {
            EventID = [eventIDStr integerValue];
        }
        
        NSDictionary *subDic = dic[DLConfigKey];
        NSArray *eventConfigs = [subDic allKeys];
        for (NSString *key in eventConfigs) {
            NSDictionary *eventDic = subDic[key];

            NSString *selectorStr = eventDic[DLSelectorKey];
            NSString *targetClass = eventDic[DLTargetKey];
            Class target = NSClassFromString(targetClass);
            SEL selector = NSSelectorFromString(selectorStr);
            
            // 返回单个方法的配置
            NSDictionary *configDic = @{key:eventDic};
            
            if (target && selector) {
                [target aspect_hookSelector:selector withOptions:DLAspectPositionBefore usingBlock:^(id<DLAspectInfo> data){
                    [AOPStatistic handleEvent:data EventID:EventID callBackDic:configDic];
                } error:nil];
            }else{
#ifdef DEBUG
                NSLog(@"target Or selector 异常");
#endif
            }
            
        }
    }
}

@end
