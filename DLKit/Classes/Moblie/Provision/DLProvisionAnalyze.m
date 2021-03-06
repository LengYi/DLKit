//
//  DLProvisionAnalyze.m
//  Pods
//
//  Created by ice on 2017/8/3.
//
//

#import "DLProvisionAnalyze.h"
//#import <openssl/x509.h>

@interface DLProvisionAnalyze ()

@end

@implementation DLProvisionAnalyze
#pragma mark - PublicMethod

- (instancetype)initWithPath:(NSString *)path{
    if (self = [super init]) {
        self.provisionPath = path;
    }
    
    return self;
}

- (instancetype)initWithProvisionData:(NSData *)data{
    self = [super init];
    if (self) {
        self.provisionData = data;
    }
    return self;
}

- (NSDictionary *)getMobileProvision{
    NSDictionary *mobileProDic = nil;
    if (self.provisionPath) {
        mobileProDic = [self getMobileProvisionWithPath:self.provisionPath];
    }else if(self.provisionData){
        mobileProDic = [self getMobileProvisionWithData:self.provisionData];
    }
    return mobileProDic;
}

- (NSDictionary *)getMobileProvisionWithPath:(NSString *)filePath{
    if (!filePath) {
        return @{};
    }
    
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    return [self getMobileProvisionWithData:data];
}

- (NSDictionary *)getMobileProvisionWithData:(NSData *)data{
    if (!data) {
        return nil;
    }
    
    NSString *binaryStr = [[NSString alloc]initWithData:data encoding:NSISOLatin1StringEncoding];
    NSDictionary *mobileProDic = [self provisonFormateToDic:binaryStr];
    
    return mobileProDic;
}

- (NSString *)teamName{
    NSDictionary *mobileProDic = [self getMobileProvision];
    if (!mobileProDic) {
        return @"";
    }
    
    NSString *teamNameStr = [mobileProDic objectForKey:@"TeamName"];
    if (!teamNameStr || [teamNameStr length] == 0)
    {
        teamNameStr = @"";
    }
    return teamNameStr;
}

- (NSString *)teamID{
    NSDictionary *mobileProDic = [self getMobileProvision];
    if (!mobileProDic) {
        return @"";
    }
    NSArray *tid = [mobileProDic objectForKey:@"TeamIdentifier"];
    if (tid && tid.count > 0) {
        return tid[0] ? : @"";
    }
    return @"";
}

- (NSString *)provisionExpiredTime{
    NSDictionary *mobileProDic = [self getMobileProvision];
    if (!mobileProDic) {
        return @"";
    }
    
    NSString *expairationTime = @"";
    if (mobileProDic) {
        id obj = mobileProDic[@"ExpirationDate"];
        if (obj) {
            if ([obj isKindOfClass:[NSData class]]) {
                expairationTime = [[NSString alloc]initWithData:obj encoding:NSUTF8StringEncoding];
                NSDateFormatter *format = [[NSDateFormatter alloc]init];
                format.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
                format.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
                NSDate *date = [format dateFromString:expairationTime];
                format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
                format.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh"];
                expairationTime = [format stringFromDate:date];
            }else if([obj isKindOfClass:[NSString class]]){
                NSDateFormatter *format = [[NSDateFormatter alloc]init];
                format.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
                format.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
                NSDate *date = [format dateFromString:obj];
                format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
                format.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh"];
                expairationTime = [format stringFromDate:date];
            }
            else if ([obj isKindOfClass:[NSDate class]])
            {
                NSDateFormatter *format = [[NSDateFormatter alloc]init];
                format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
                format.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh"];
                format.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
                expairationTime = [format stringFromDate:obj];
            }
        }
    }
    
    if (!expairationTime) {
        expairationTime = @"";
    }
    
    return expairationTime;
}

//+ (NSDate *)cerExpireTime{
//    NSDate *date = [[NSDate alloc] init];
//    NSDictionary *dic = [self getMobileProvision];
//        if (dic) {
//            X509 *x509Cer;
//
//            NSArray * cerDataArray = dic[@"DeveloperCertificates"];
//            if (cerDataArray) {
//                for (NSData *cerData in cerDataArray) {
//                    x509Cer = [self cerDataFormateToX509:cerData];
//                    if (x509Cer) {
//                        ASN1_TIME *end = NULL;
//                        time_t ttEnd = {0};
//
//                        // 过期时间
//                        end = X509_get_notAfter(x509Cer);
//                        ttEnd = [self skf_ext_ASN1_GetTimeT:end];
//                        ttEnd = ttEnd + 8 * 60 * 60;
//                        NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:ttEnd];
//
//                        if (date) {
//                            date = [endDate laterDate:date];
//                        }else
//                        {
//                            date = endDate;
//                        }
//                    }
//                }
//            }
//        }
//
//    return date;
//}

#pragma mark - PrivateMethod

- (NSDictionary *)provisonFormateToDic:(NSString *)binaryStr{
    if (!binaryStr) {
        return nil;
    }
    
    NSScanner *scanner = [NSScanner scannerWithString:binaryStr];
    BOOL ok = [scanner scanUpToString:@"<plist" intoString:nil];
    if (!ok) {
        return nil;
    }
    
    NSString *plistString;
    ok = [scanner scanUpToString:@"</plist>" intoString:&plistString];
    if (!ok) {
        return nil;
    }
    
    plistString = [NSString stringWithFormat:@"%@</plist>",plistString];
    // latin1 back to utf-8!
    NSData *plistdata_latin1 = [plistString dataUsingEncoding:NSISOLatin1StringEncoding];
    NSError *error = nil;
    NSDictionary *mobileProvision = [NSPropertyListSerialization propertyListWithData:plistdata_latin1
                                                                              options:NSPropertyListImmutable
                                                                               format:NULL
                                                                                error:&error];
    if (error) {
        return nil;
    }
    return mobileProvision;
}


//+ (X509 *)cerDataFormateToX509:(NSData *)cerData{
//    if (!cerData) {
//        return nil;
//    }
//    char * Cert = (char*)[cerData bytes];
//    char *tmp = Cert;
//    X509 *x509Cer = d2i_X509(NULL, (const unsigned char **)&tmp, cerData.length);
//    return x509Cer;
//}
//
////时间格式转换
//+ (time_t)skf_ext_ASN1_GetTimeT:(ASN1_TIME *)time {
//    struct tm t;
//    const char* str = (const char*) time->data;
//    size_t i = 0;
//
//    memset(&t, 0, sizeof(t));
//
//    if (time->type == V_ASN1_UTCTIME) {/* two digit year */
//        t.tm_year = (str[i++] - '0') * 10;
//        t.tm_year += (str[i++] - '0');
//        if (t.tm_year < 70)
//            t.tm_year += 100;
//    } else if (time->type == V_ASN1_GENERALIZEDTIME) {/* four digit year */
//        t.tm_year = (str[i++] - '0') * 1000;
//        t.tm_year+= (str[i++] - '0') * 100;
//        t.tm_year+= (str[i++] - '0') * 10;
//        t.tm_year+= (str[i++] - '0');
//        t.tm_year -= 1900;
//    }
//    t.tm_mon  = (str[i++] - '0') * 10;
//    t.tm_mon += (str[i++] - '0') - 1; // -1 since January is 0 not 1.
//    t.tm_mday = (str[i++] - '0') * 10;
//    t.tm_mday+= (str[i++] - '0');
//    t.tm_hour = (str[i++] - '0') * 10;
//    t.tm_hour+= (str[i++] - '0');
//    t.tm_min  = (str[i++] - '0') * 10;
//    t.tm_min += (str[i++] - '0');
//    t.tm_sec  = (str[i++] - '0') * 10;
//    t.tm_sec += (str[i++] - '0');
//
//    /* Note: we did not adjust the time based on time zone information */
//    return mktime(&t);
//}
@end

