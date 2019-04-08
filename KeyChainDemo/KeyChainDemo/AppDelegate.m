//
//  AppDelegate.m
//  KeyChainDemo
//
//  Created by mkrq-yh on 2019/4/4.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "AppDelegate.h"
#import "SQLite/SQLiteDBManager.h"
#import "FMDBManager.h"
#import <Realm/Realm.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //打开数据库
    [SQLiteDBManager openDB];
    //打开数据库
    [FMDBManager openDBForQueue];
    
    //使用RealmDB
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *dbFolder = [documentPath stringByAppendingPathComponent:@"RealmDB"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:dbFolder]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:dbFolder withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *filePath = [dbFolder stringByAppendingPathComponent:@"db.realm"];
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    //路径
    config.fileURL = [NSURL URLWithString:filePath];
    //是否只读
    config.readOnly = NO;
    //当前版本
    config.schemaVersion = 4;
    [RLMRealmConfiguration setDefaultConfiguration:config];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
