//
//  SQLiteDBManager.h
//  KeyChainDemo
//
//  Created by mkrq-yh on 2019/4/8.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQLiteDBManager : NSObject

/**
 单利创建Manager
 
 @return return value description
 */
+ (instancetype)sharedInstance;

/**
 打开数据库
 */
+ (void)openDB;

/**
 关闭数据库
 */
+ (void)closeDB;

/**
 删除数据库
 
 @return BOOL
 */
+ (BOOL)deleteSQliteDB;

/**
 创建表
 
 @param sql sql语句
 @return BOOL
 */
+ (BOOL)createTableWithSql:(NSString *)sql;

/**
 增删改操作
 
 @param sql sql语句
 @return BOOL
 */
+ (BOOL)operationRecordWithSql:(NSString *)sql;

/**
 查询记录
 
 @param sql sql语句
 @return NSArray
 */
+ (NSArray *)selectRecordWithSql:(NSString *)sql;

@end

NS_ASSUME_NONNULL_END
