//
//  MusicDefaults.m
//  KeyChainDemo
//
//  Created by mkrq-yh on 2019/4/8.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "MusicDefaults.h"

@implementation MusicDefaults

#pragma mark - 保存音乐到沙盒路径
+ (void)toolToSaveMusicToCache:(NSString *)musicUrlStr withMusicName:(NSString *)name {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_queue_create("musicQueue", DISPATCH_QUEUE_PRIORITY_DEFAULT), ^{
        //已经存了
        if ([weakSelf alreadySaveMusic:name])
            return ;
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:musicUrlStr]];
        [data writeToFile:[weakSelf getPathWithMusicName:name] atomically:YES];
    });
}

#pragma mark - 获取沙盒路径下的音乐
+ (NSString *)toolToGetMusicFromCache:(NSString *)musicName {
    NSString *musicPath = [self getPathWithMusicName:musicName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:musicPath]) {
        return musicPath;
    }
    return nil;
}

#pragma mark - 获取沙盒路径下的音乐
+ (NSString *)getPathWithMusicName:(NSString *)name {
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePathFolder = [documentPath stringsByAppendingPaths:@[@"music"]].firstObject;
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePathFolder]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:filePathFolder withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *path = [NSString stringWithFormat:@"%@/%@.mp3",filePathFolder,name];
    return path;
}

#pragma mark - 判断是否已经存储了音乐
+ (BOOL)alreadySaveMusic:(NSString *)musicName {
    NSString *musicPath = [self getPathWithMusicName:musicName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:musicPath]) {
        return NO;
    } else {
        NSData *data = [NSData dataWithContentsOfFile:musicPath];
        if (data.length > 0) {
            return YES;
        }
        return NO;
    }
}

@end
