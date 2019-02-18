//
//  PictureView.h
//  ZhaiTu
//
//  Created by mkrq-yh on 2019/2/18.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PictureView : UIView

/*
 frame:
 imgView:图片数组
 index:当前显示
 */
- (instancetype)initWithFrame:(CGRect)frame withImg:(NSArray *)array currentIndex:(NSInteger)index from:(UIView *)fview;;

@end

NS_ASSUME_NONNULL_END
