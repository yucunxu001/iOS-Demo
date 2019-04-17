//
//  LunBoFlowLayout.h
//  LunBoDemo
//
//  Created by mkrq-yh on 2019/4/16.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LunBoFlowLayout : UICollectionViewFlowLayout

@property (nonatomic) CGSize itemSize;
@property (nonatomic) NSInteger visibleCount;
@property (nonatomic) UICollectionViewScrollDirection scrollDirection;

@end

NS_ASSUME_NONNULL_END
