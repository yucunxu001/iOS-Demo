//
//  UIPasteboard+AttributedString.h
//  TestDemo
//
//  Created by mkrq-yh on 2018/12/5.
//  Copyright © 2018 mkrq-yh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <MobileCoreServices/UTCoreTypes.h>//添加此框架

NS_ASSUME_NONNULL_BEGIN

@interface UIPasteboard (AttributedString)

- (void)setAttributedString:(NSAttributedString *)attributedString;

@end

NS_ASSUME_NONNULL_END
