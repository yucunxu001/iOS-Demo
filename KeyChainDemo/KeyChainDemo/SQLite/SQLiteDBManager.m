//
//  SQLiteDBManager.m
//  KeyChainDemo
//
//  Created by mkrq-yh on 2019/4/8.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "SQLiteDBManager.h"
#import <sqlite3.h>

@interface SQLiteDBManager ()

@property (nonatomic, assign) sqlite3 *db;

@end

@implementation SQLiteDBManager

#pragma mark - 创建对象
+ (instancetype)sharedInstance {
    static SQLiteDBManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SQLiteDBManager alloc] init];
    });
    return manager;
}
- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}
#pragma mark - 打开数据库
+ (void)openDB {
    sqlite3 *sql = [SQLiteDBManager sharedInstance].db;
    sqlite3_open([[SQLiteDBManager getDBpath] UTF8String], &sql);
    [SQLiteDBManager sharedInstance].db = sql;
}

+ (NSString *)getDBpath {
    NSString *documentStr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *sqlDBFolder = [documentStr stringByAppendingPathComponent:@"SQLiteDB"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:sqlDBFolder]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:sqlDBFolder withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return [sqlDBFolder stringByAppendingPathComponent:@"dataDemo.sqlite"];
}

#pragma mark - 关闭数据库
+ (void)closeDB {
    sqlite3_close([SQLiteDBManager sharedInstance].db);
}

#pragma mark - 删除数据库
+ (BOOL)deleteSQliteDB {
    NSString *documentStr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *sqlDBFolder = [documentStr stringByAppendingPathComponent:@"SQLiteDB"];
    NSError *error;
    if ([[NSFileManager defaultManager] fileExistsAtPath:sqlDBFolder]) {
        [[NSFileManager defaultManager] removeItemAtPath:sqlDBFolder error:&error];
    }
    if (error) {
        return NO;
    }
    return YES;
}

#pragma mark - 创建表
+ (BOOL)createTableWithSql:(NSString *)sql {
    sqlite3 *sqlite = [[SQLiteDBManager sharedInstance] db];
    char *errorMsg = "";
    if (sqlite3_exec(sqlite, [sql UTF8String], nil, nil, &errorMsg) == SQLITE_OK) {
        return YES;
    } else {
        NSLog(@"创建表失败");
        return NO;
    }
}

#pragma mark - 查询
+ (NSArray *)selectRecordWithSql:(NSString *)sql {
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2([SQLiteDBManager sharedInstance].db, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK) {
        NSMutableArray *array = [NSMutableArray array];
        //执行sql语句
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            //获取列数
            int columnCount = sqlite3_column_count(stmt);
            //获取每一列的值与列明放入字典数组中
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            for (int i = 0; i < columnCount; i++) {
                //获取值
                char *value = (char *)sqlite3_column_text(stmt, i);
                NSString *valueStr;
                if (value != NULL) {
                    valueStr = [NSString stringWithUTF8String:value];
                }
                //获取key
                char *key = (char *)sqlite3_column_name(stmt, i);
                NSString *keyStr = [NSString stringWithUTF8String:key];
                dict[keyStr] = valueStr;
            }
            [array addObject:dict];
        }
        sqlite3_finalize(stmt);
        return array;
    }
    return @[];
}


/**
 增删改操作记录
 
 @param sql sql语句
 @return BOOL
 */
+ (BOOL)operationRecordWithSql:(NSString *)sql {
    //对sql执行预编译
    sqlite3_stmt *stmt;
    //sqlite3_prepare_v2是执行查询的方法
    if (sqlite3_prepare_v2([SQLiteDBManager sharedInstance].db, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK) {
        //执行sql语句
        if (sqlite3_step(stmt) == SQLITE_DONE) {
            sqlite3_finalize(stmt);
            return YES;
        }
    }
    return NO;
}

@end
