//
//  CircleProgress.h
//  ZhaiTu
//
//  Created by mkrq-yh on 2019/3/25.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CircleProgress : UIView

@property (nonatomic, assign) CGFloat progress;//进度
@property (nonatomic, strong) UIColor *mainColor;// 主色调,进度条颜色
@property (nonatomic, strong) UIColor *fillColor;// 进度条背景颜色
@property (nonatomic, assign) CGFloat lineWidth;//  线宽
@property (nonatomic, assign) CGFloat duration;//   进度时间


@end

NS_ASSUME_NONNULL_END
