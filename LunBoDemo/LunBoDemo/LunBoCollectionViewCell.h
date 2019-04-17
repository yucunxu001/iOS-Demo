//
//  LunBoCollectionViewCell.h
//  LunBoDemo
//
//  Created by mkrq-yh on 2019/4/16.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LunBoCollectionViewCell : UICollectionViewCell

- (void)setUpAllChildView:(NSDictionary *)dict ForRowAtIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIImageView *itemImg;
@property (nonatomic,strong) UILabel *itemLb;

@end

NS_ASSUME_NONNULL_END
