//
//  HttpRequest.h
//  BlockDemo
//
//  Created by mkrq-yh on 2018/11/29.
//  Copyright © 2018 mkrq-yh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^BlockSuccess)(id obj);
typedef void(^BlockFailure)(NSError *error);

@interface HttpRequest : NSObject

+ (instancetype)sharedInstance;

- (void)postWithUrl:(NSString *)url withParams:(NSDictionary *)params withSuccess:(BlockSuccess)success withFailure:(BlockFailure)failure;

@end

NS_ASSUME_NONNULL_END
