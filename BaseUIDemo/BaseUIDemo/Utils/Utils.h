//
//  Utils.h
//  BaseUIDemo
//
//  Created by mkrq-yh on 2019/1/10.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Utils : NSObject

#pragma mark - 颜色相关
+ (UIColor *)colorWithHexString: (NSString *)color;
+ (UIColor *)colorWithHexString: (NSString *)color WithAlpha:(float)alpha;


@end

NS_ASSUME_NONNULL_END
