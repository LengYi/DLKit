//
//  GYMockRequest+Extended.h
//  Pods
//
//  Created by ice on 2017/8/11.
//
//

#import <GYHttpMock/GYHttpMock.h>

@interface GYMockRequest (Extended)
- (BOOL)matchesRequest:(id<GYHTTPRequest>)request;
@end
