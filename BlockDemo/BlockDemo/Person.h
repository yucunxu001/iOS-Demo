//
//  Person.h
//  BlockDemo
//
//  Created by mkrq-yh on 2019/4/30.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^Success)(NSString *food);

@interface Person : NSObject

@property (nonatomic,strong) void (^block)(void);

//使用block做参数
- (void)eatFoos:(Success)success;
//返回block无参无返回值
- (void(^)(void))look;
//返回block有参无返回值
- (void(^)(NSString *name))play;
//返回block有参有返回值
- (Person *(^)(int))sleep;

@end

NS_ASSUME_NONNULL_END
