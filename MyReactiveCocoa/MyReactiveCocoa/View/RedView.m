//
//  RedView.m
//  MyReactiveCocoa
//
//  Created by mkrq-yh on 2019/4/9.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "RedView.h"

@implementation RedView
{
    UIView *bgView;
    UIButton *button;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        bgView.backgroundColor = [UIColor redColor];
        [self addSubview:bgView];
        
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(20, 20, self.frame.size.width-40, 50);
        [button setTitle:@"使用RACSubject替代代理" forState:UIControlStateNormal];
        button.backgroundColor = [UIColor greenColor];
        [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:button];
        
    }
    return self;
}

//懒加载信号
- (RACSubject *)btnClickSignal {
    if (_btnClickSignal == nil) {
        _btnClickSignal = [RACSubject subject];
    }
    return _btnClickSignal;
}

- (void)btnClick {
    [self.btnClickSignal sendNext:@"按钮被点击了"];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
