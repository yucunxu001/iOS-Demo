//
//  MusicDefaults.h
//  KeyChainDemo
//
//  Created by mkrq-yh on 2019/4/8.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MusicDefaults : NSObject

/** 保存音乐到沙盒路径
 @param musicUrlStr url地址
 */
+ (void)toolToSaveMusicToCache:(NSString *)musicUrlStr withMusicName:(NSString *)name;

/** 获取沙盒路径下的音乐
 @param musicName 音乐名称
 @return 路径
 */
+ (NSString *)toolToGetMusicFromCache:(NSString *)musicName;

/** 获取沙盒路径下的音乐
 @return return value description
 */
+ (NSString *)getPathWithMusicName:(NSString *)name;

/** 判断是否已经存储了音乐
 @param musicName 音乐名称
 @return return value description
 */
+ (BOOL)alreadySaveMusic:(NSString *)musicName;

@end

NS_ASSUME_NONNULL_END
