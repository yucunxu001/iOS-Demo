//
//  Person.h
//  OCDemo
//
//  Created by mkrq-yh on 2019/3/20.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (nonatomic,strong) NSString *name;

//第一种就是直接赋值
- (void)changeName:(NSString *)name;
//第二种点语法赋值
- (void)changeNameFromSetter:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
