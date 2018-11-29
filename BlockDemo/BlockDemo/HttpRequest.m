//
//  HttpRequest.m
//  BlockDemo
//
//  Created by mkrq-yh on 2018/11/29.
//  Copyright © 2018 mkrq-yh. All rights reserved.
//

#import "HttpRequest.h"

@implementation HttpRequest

static HttpRequest * _instance = nil;
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init] ;
    }) ;
    return _instance ;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [HttpRequest sharedInstance] ;
}

- (id)copyWithZone:(struct _NSZone *)zone
{
    return [HttpRequest sharedInstance] ;
}


- (void)postWithUrl:(NSString *)url withParams:(NSDictionary *)params withSuccess:(BlockSuccess)success withFailure:(BlockFailure)failure {
    BOOL result = true;
    if (result) {
        success(@{@"value":@"123456"});
    } else {
        NSError *error = [[NSError alloc] init];
        failure(error);
    }
}


@end
