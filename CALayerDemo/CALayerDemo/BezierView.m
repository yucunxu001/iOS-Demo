//
//  BezierView.m
//  CALayerDemo
//
//  Created by mkrq-yh on 2019/5/10.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "BezierView.h"

@implementation BezierView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
//    [self drawLine];
//    [self drawPolygon];
//    [self drawRectangular];
//    [self drawEllipse];
//    [self drawArc];
//    [self drawQuadCurve];
//    [self drawCurve];
    [self drawBezierPathWithRect];
//    [self bezierPathWithRoundedRect];
}

#pragma mark - 画直线
- (void)drawLine {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(50, 200)];//设置初始点
    [path addLineToPoint:CGPointMake(100, 100)];
    [path addLineToPoint:CGPointMake(150, 200)];
    [path addLineToPoint:CGPointMake(200, 100)];
    [path addLineToPoint:CGPointMake(250, 200)];
 
    path.lineWidth = 10.0;//线条宽度
    path.lineCapStyle = kCGLineCapRound; //线条拐角样式
    path.lineJoinStyle = kCGLineJoinRound; //终点处理样式
    UIColor *color = [UIColor redColor];
    [color set];//设置颜色
    [path stroke];//用 stroke 得到的是不被填充的 view ，[path fill]; 用 fill 得到的内部被填充的 view
}

#pragma mark - 绘制多边形
- (void)drawPolygon {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(100, 400)];
    [path addLineToPoint:CGPointMake(100, 200)];
    [path addLineToPoint:CGPointMake(200, 100)];
    [path addLineToPoint:CGPointMake(300, 200)];
    [path addLineToPoint:CGPointMake(300, 400)];
    [path closePath];//第五条线通过调用closePath方法得到的
    [[UIColor greenColor] set];
//    [path stroke];
    [path fill];

}

#pragma mark -画椭圆
- (void)drawRectangular {
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(50, 100, 300, 200)];
    path.lineWidth = 2;
    [[UIColor redColor] set];
    [path stroke];
}

#pragma mark -画椭圆
- (void)drawEllipse {
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 100, 200, 150)];
    path.lineWidth = 2;
    [[UIColor redColor] set];
    [path stroke];
}

#pragma mark -画弧
- (void)drawArc
{
    /*
     ArcCenter: 原点
     radius: 半径
     startAngle: 开始角度
     endAngle: 结束角度
     clockwise: 是否顺时针方向
     */
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(200, 200) radius:100 startAngle:0 endAngle:M_PI*0.3 clockwise:YES];
    path.lineWidth = 2;
    [[UIColor redColor] set];
    [path stroke];


}

#pragma mark - 绘制二次贝塞尔曲线
- (void)drawQuadCurve {
    /*
     moveToPoint设置起点
     endPoint终点
     controlPoint控制点
     通过addQuadCurveToPoint方法可以画 正弦 余弦
     */
    UIBezierPath *path = [UIBezierPath bezierPath];
    [[UIColor redColor] set];
    [path moveToPoint:CGPointMake(100, 300)];
    [path addQuadCurveToPoint:CGPointMake(300, 300) controlPoint:CGPointMake(200, 100)];
    [path stroke];
}

#pragma mark - 绘制三次贝塞尔曲线
- (void)drawCurve
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [[UIColor redColor] set];
    [path moveToPoint:CGPointMake(100, 300)];
    [path addCurveToPoint:CGPointMake(300, 300) controlPoint1:CGPointMake(200, 200) controlPoint2:CGPointMake(200, 400)];
    [path stroke];
}

#pragma mark - 绘制一个带内切圆的矩形
- (void)drawBezierPathWithRect{
    UIColor *color = [UIColor redColor];
    [color set]; //设置线条颜色
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(100, 100, 200, 100) cornerRadius:50];
    path.lineWidth = 5.0;
    path.lineCapStyle = kCGLineCapRound; //线条拐角
    path.lineJoinStyle = kCGLineJoinRound; //终点处理
    [path stroke];
}

#pragma mark - 绘制一个半角矩形
- (void)bezierPathWithRoundedRect{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(100, 100, 200, 100) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(50, 50)];
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineWidth = 5.0;
    [path stroke];
}

@end
