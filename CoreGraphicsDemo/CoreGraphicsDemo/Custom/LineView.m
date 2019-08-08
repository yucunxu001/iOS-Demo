//
//  LineView.m
//  CoreGraphicsDemo
//
//  Created by mkrq-yh on 2019/5/27.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "LineView.h"

@implementation LineView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置画笔颜色
    CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
    //设置线条宽度
    CGContextSetLineWidth(context, 5);
    //设置起始点
    CGContextMoveToPoint(context, 0, 0);
    //添加路径到图形上下文
    CGContextAddLineToPoint(context, 50, 50);
    CGContextAddLineToPoint(context, 100, 50);
    CGContextAddLineToPoint(context, 100, 100);
    //    CGPoint points[] = {{0,0},{50,30},{60,100},{200,100},{200,200}};
    //    CGContextAddLines(context, points, 5);
    //画虚线
    //    CGFloat lengths[] = {10,10};//表示先绘制10个点，再跳过10个点，如此反复
    //    CGContextSetLineDash(context, 0, lengths,2);
    //画图形上下文的路径
    CGContextStrokePath(context);
}


@end
