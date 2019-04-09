//
//  RealmBaseModel.m
//  KeyChainDemo
//
//  Created by mkrq-yh on 2019/4/8.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "RealmBaseModel.h"

@implementation RealmBaseModel

//主键
+ (NSString *)primaryKey {
    return @"userId";
}
//需要添加索引的属性
+ (NSArray<NSString *> *)requiredProperties {
    return @[@"userId"];
}
//默认属性值
+ (NSDictionary *)defaultPropertyValues {
    return @{@"address":@"北京"};
}
//忽略的字段
+ (NSArray *)ignoredProperties {
    return @[];
}
//索引属性,主要用于搜索,根据性别进行搜索
+ (NSArray<NSString *> *)indexedProperties {
    return @[@"userId"];
}

@end
