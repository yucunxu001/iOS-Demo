//
//  FlexTableViewCell.h
//  FlexLibDemo
//
//  Created by mkrq-yh on 2018/11/27.
//  Copyright © 2018 mkrq-yh. All rights reserved.
//

#import "FlexBaseTableCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface FlexTableViewCell : FlexBaseTableCell

@property(nonatomic,strong) UILabel *name;
@property(nonatomic,strong) UILabel *title;
@property(nonatomic,strong) UILabel *content;
@property(nonatomic,strong) UIImageView *imgView;

- (void)setData:(NSDictionary *)datas;

@end

NS_ASSUME_NONNULL_END
