//
//  NSUserDefaults+Category.m
//  KeyChainDemo
//
//  Created by mkrq-yh on 2019/4/8.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "NSUserDefaults+Category.h"

static NSString * const phoneNumberKey = @"phoneNumberKey";

@implementation NSUserDefaults (Category)

#pragma mark - 保存数据
+ (void)saveData:(nullable id)data withKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];//使用synchronize强制立即将数据写入磁盘
}

#pragma mark - 获取数据
+ (nullable id)getSaveData:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

#pragma mark - 删除数据
+ (void)removeSaveDataWithKey:(NSString *)key {
    NSUserDefaults *defaults = [[NSUserDefaults alloc] init];
    [defaults removeObjectForKey:key];
}

@end
