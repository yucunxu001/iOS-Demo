//
//  CustomView.m
//  OCDemo
//
//  Created by mkrq-yh on 2019/3/20.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

- (instancetype)initWithFrame:(CGRect)frame withVC:(UIViewController *)vc
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    [_bgView removeFromSuperview];
    _bgView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:_bgView];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(20, 20, 200, 50);
    [btn2 setTitle:@"发送通知" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn2.titleLabel.font = [UIFont systemFontOfSize:16];
    btn2.backgroundColor = [UIColor greenColor];
    btn2.tag = 101;
    [btn2 addTarget:self action:@selector(btnLClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:btn2];
    
}

- (void)btnLClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedItemButton:)]) {
        [self.delegate selectedItemButton:sender.tag];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
