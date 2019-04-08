//
//  NSUserDefaults+Category.h
//  KeyChainDemo
//
//  Created by mkrq-yh on 2019/4/8.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSUserDefaults (Category)

/**保存数据
 @data - 需要保存的数据
 @key
 */
+ (void)saveData:(nullable id)data withKey:(NSString *)key;

/**获取数据
 @key
 */
+ (nullable id)getSaveData:(NSString *)key;

/**删除数据
 @key
 */
+ (void)removeSaveDataWithKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
