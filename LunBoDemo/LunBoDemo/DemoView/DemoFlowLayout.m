//
//  DemoFlowLayout.m
//  LunBoDemo
//
//  Created by mkrq-yh on 2019/4/16.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "DemoFlowLayout.h"

@interface DemoFlowLayout()

@property (nonatomic,assign) CGFloat Width;//UICollectionView宽度
@property (nonatomic,assign) CGFloat cellWidth;//cell高度

@end

@implementation DemoFlowLayout

/**
 * 用来做布局的初始化操作（不建议在init方法中进行布局的初始化操作）
 */
- (void)prepareLayout {
    [super prepareLayout];
    
    self.visibleCount = 3;
    self.Width = CGRectGetWidth(self.collectionView.frame);
    self.cellWidth = self.itemSize.width;
    self.scale = 1.0;
    
}

/*
 中间的滚动视图是一块一块移动的，停止时距离中间最近的卡片会自动滑动到中间，居中对齐。
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGFloat offsetAdjustment = MAXFLOAT;
    //中心距离
    CGFloat centerX = proposedContentOffset.x+self.Width/2;
    CGRect targetRect = CGRectMake(proposedContentOffset.x, proposedContentOffset.y, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    NSArray *array = [super layoutAttributesForElementsInRect:targetRect];
    for (UICollectionViewLayoutAttributes *attribute in array) {
        CGFloat offset = attribute.center.x - centerX;
        if (ABS(offset) < ABS(offsetAdjustment)) {
            offsetAdjustment = offset;
        }
    }
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
}
/*
 中间的滚动视图在滑动的时候发现卡片是叠在一起的，中间的在上层，其他部分在下层，根据距离中间位置的远近来区别上下层。
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    NSLog(@"rect.origin.x==%f",rect.origin.x);
    NSLog(@"rect.size.width==%f",rect.size.width);

    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
    //此时的显示 中心
    CGFloat centerX =  self.collectionView.contentOffset.x + self.Width/2;
    //计算l距离中心最近的cell下标
    NSInteger index = centerX / self.cellWidth;
    for (UICollectionViewLayoutAttributes *attribute in array) {
        CGFloat offset = ABS(attribute.center.x-centerX);
        CGFloat space = self.cellWidth;
        if (offset<space) {
            CGFloat currentScale = (1-offset/space)*(1-self.scale);
//            CGFloat currentScale = 0.8;
            NSLog(@"currentScale==%f",currentScale);
            attribute.transform = CGAffineTransformMakeScale(currentScale, currentScale);
            attribute.zIndex = 1;
        } else if (offset>space) {
            CGFloat currentScale2 = 0.8;
            attribute.transform = CGAffineTransformMakeScale(currentScale2, currentScale2);

        }
    }

    return array;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];

    return attribute;
}

//- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
//    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
//    CGFloat centerY =  self.collectionView.contentOffset.x + self.viewHeight/2;
//    NSInteger index = centerY / self.itemHeight;
//    NSInteger count = (self.visibleCount - 1) / 2;
//    NSInteger minIndex = MAX(0, (index - count));
//    NSInteger maxIndex = MIN((cellCount - 1), (index + count));
//    NSMutableArray *array = [NSMutableArray array];
//    for (NSInteger i = minIndex; i <= maxIndex; i++) {
//        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
//        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
//        [array addObject:attributes];
//    }
//    return array;
//}


- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}



@end
