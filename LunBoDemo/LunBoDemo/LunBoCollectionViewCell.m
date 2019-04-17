//
//  LunBoCollectionViewCell.m
//  LunBoDemo
//
//  Created by mkrq-yh on 2019/4/16.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "LunBoCollectionViewCell.h"

@implementation LunBoCollectionViewCell

- (void)setUpAllChildView:(NSDictionary *)dict ForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat cellWidth = self.contentView.frame.size.width;
    CGFloat cellHeight = self.contentView.frame.size.height;

    [_bgView removeFromSuperview];
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cellWidth, cellHeight)];
    _bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_bgView];
    
    _itemImg = [[UIImageView alloc] initWithFrame:_bgView.bounds];
    [_itemImg setImage:[UIImage imageNamed:dict[@"img"]]];
//    _itemImg.layer.borderColor = [UIColor blackColor].CGColor;
//    _itemImg.backgroundColor = [UIColor grayColor];
    [_bgView addSubview:_itemImg];
    
    _itemLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, _bgView.frame.size.width, 40)];
    _itemLb.text = dict[@"title"];
    _itemLb.font = [UIFont boldSystemFontOfSize:14];
    _itemLb.textColor = [UIColor redColor];
    _itemLb.textAlignment = NSTextAlignmentCenter;
    [_bgView addSubview:_itemLb];
}

@end
