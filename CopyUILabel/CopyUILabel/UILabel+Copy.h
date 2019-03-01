//
//  UILabel+Copy.h
//  CopyUILabel
//
//  Created by mkrq-yh on 2019/3/1.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Copy)

@property (nonatomic, assign) BOOL copyable;
@property (nonatomic, copy) NSString *copyString;


@end

NS_ASSUME_NONNULL_END
