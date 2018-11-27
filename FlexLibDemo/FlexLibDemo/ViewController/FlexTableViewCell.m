//
//  FlexTableViewCell.m
//  FlexLibDemo
//
//  Created by mkrq-yh on 2018/11/27.
//  Copyright © 2018 mkrq-yh. All rights reserved.
//

#import "FlexTableViewCell.h"

@implementation FlexTableViewCell


- (void)setData:(NSDictionary *)datas
{
    self.name.text = datas[@"one"];
    self.title.text = datas[@"title"];
    self.content.text = datas[@"content"];
    self.imgView.image = [UIImage imageNamed:@"80-80"];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
