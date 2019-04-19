//
//  DemoFlowLayout.h
//  LunBoDemo
//
//  Created by mkrq-yh on 2019/4/16.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DemoFlowLayout : UICollectionViewFlowLayout

/*
 可以看见几个cell，默认3个
 */
@property (nonatomic) NSInteger visibleCount;

/*
 缩放率
 */
@property (nonatomic, assign) CGFloat scale;

@end

NS_ASSUME_NONNULL_END
