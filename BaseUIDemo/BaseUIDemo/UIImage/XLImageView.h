//
//  XLImageView.h
//  ZhaiTu
//
//  Created by mkrq-yh on 2019/2/18.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XLImageView : UIView

@property (nonatomic,copy) NSString *imageUrl;

@property (nonatomic,assign) UIViewContentMode imageContentMode;


@end

NS_ASSUME_NONNULL_END
