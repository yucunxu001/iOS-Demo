//
//  TouchView.m
//  CoreAnimationDemo
//
//  Created by mkrq-yh on 2019/4/25.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "TouchView.h"

@implementation TouchView
{
    UIButton *redBtn;
    UIButton *buleBtn;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        
        redBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        redBtn.frame = CGRectMake(0, 0,  50, 50);
        redBtn.backgroundColor = [UIColor redColor];
        [redBtn addTarget:self action:@selector(rebBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:redBtn];
        
        UIButton *buleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        buleBtn.frame = CGRectMake(10, 10,  30, 30);
        buleBtn.backgroundColor = [UIColor blueColor];
        [buleBtn addTarget:self action:@selector(buleBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buleBtn];
    }
    return self;
}

- (void)rebBtnClick {
    NSLog(@"rebBtnClick");
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [CATransaction setAnimationDuration:3];
    [CATransaction setCompletionBlock:^{
        NSLog(@"111完成了");
    }];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
    animation.duration = 3;
    animation.fromValue = @(1.0);
    animation.toValue = @(0.2);
    [redBtn.layer addAnimation:animation forKey:@""];
    
    [CATransaction commit];
}
- (void)buleBtnClick {
    NSLog(@"buleBtnClick");
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [CATransaction setAnimationDuration:3];
    [CATransaction setCompletionBlock:^{
        NSLog(@"222完成了");
    }];
    buleBtn.backgroundColor = [UIColor yellowColor];
    [CATransaction commit];
}

- (void)setHomeButtonView:(UIView *)homeButtonView {
//    [self addSubview:homeButtonView];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    

}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];

}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//    //获取到当前点击的view
//    UIView *hitView = [super hitTest:point withEvent:event];
//    if (hitView != self) {
//        for (UIView *subview in self.subviews) {
//            //判断该坐标是否在视图内部，如果是，则返回该视图
//            if (CGRectContainsPoint(subview.frame, point)) {
//                return subview;
//            }
//        }
//    }
//    return self;
//}


//// 在父视图中实现方法
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    // 1.这是当前点击的视图，如果没有找到合适的响应操作的视图，则直接返回这个
//    UIView *view = [super hitTest:point withEvent:event];
//
//    // 2.将父视图坐标转成我想要响应事件的视图的坐标
//    CGPoint buttonPoint = [self convertPoint:point toView:self.button];
//
//    // 3.判断该坐标是否在视图内部，如果是，则返回该视图
//    if ([self.button pointInside:buttonPoint withEvent:event]) {
//        return self.button;
//    }
//    return view;
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
