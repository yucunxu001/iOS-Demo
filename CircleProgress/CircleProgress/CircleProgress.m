//
//  CircleProgress.m
//  ZhaiTu
//
//  Created by mkrq-yh on 2019/3/25.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "CircleProgress.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)//角都转弧度

@interface CircleProgress()

@property (nonatomic, strong) CAShapeLayer *backLayer;
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, strong) UIBezierPath *progressPath;
@property (nonatomic, strong) UILabel *countJump;
@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation CircleProgress

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _progress = 0;
        _mainColor = [UIColor redColor];
        _fillColor = [UIColor clearColor];
        _lineWidth = 1;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.width/2);//中心
    CGFloat radius = (self.bounds.size.width-_lineWidth)/2;//半径
    CGFloat startA = DEGREES_TO_RADIANS(0);//设置进度条起点位置
    CGFloat endA = DEGREES_TO_RADIANS(360);  //设置进度条终点点位置
    
    _backLayer = [CAShapeLayer layer];//创建一个track shape layer
    _backLayer.frame = self.bounds;
    _backLayer.fillColor = [[UIColor clearColor] CGColor];  //填充色为无色
    _backLayer.strokeColor = _fillColor.CGColor; //指定path的渲染颜色,这里可以设置任意不透明颜色
    _backLayer.opacity = 1; //背景颜色的透明度
    _backLayer.lineCap = kCALineCapSquare;//指定线的边缘是圆的
    _backLayer.lineWidth = _lineWidth;//线的宽度
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];//上面说明过了用来构建圆
    _backLayer.path =[path CGPath]; //把path传递給layer，然后layer会处理相应的渲染，整个逻辑和CoreGraph是一致的。
    [self.layer addSublayer:_backLayer];
    
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.frame = self.bounds;
    _progressLayer.fillColor = [UIColor clearColor].CGColor;
    _progressLayer.strokeColor = _mainColor.CGColor;
    _progressLayer.opacity = 1;
    _progressLayer.lineCap = kCALineCapSquare;
    _progressLayer.lineWidth = _lineWidth;
    [self.layer addSublayer:_progressLayer];

    CGFloat startA2 = DEGREES_TO_RADIANS(270);//设置进度条起点位置
    CGFloat endA2 = DEGREES_TO_RADIANS(270)+DEGREES_TO_RADIANS(360)*_progress;  //设置进度条终点点位置

    UIBezierPath *path2 = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA2 endAngle:endA2 clockwise:YES];//上面说明过了用来构建圆
    _progressLayer.path =[path2 CGPath]; //把path传递給layer，然后layer会处理相应的渲染，整个逻辑和CoreGraph是一致的。
    [self.layer addSublayer:_progressLayer];

    [_progressLayer removeAnimationForKey:@"animation1"];
    CABasicAnimation *pathAniamtion = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAniamtion.duration = _duration;// 时间
    pathAniamtion.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];//动画节奏
    pathAniamtion.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAniamtion.toValue = [NSNumber numberWithFloat:1.0];
    [_progressLayer addAnimation:pathAniamtion forKey:@"animation1"];
}

#pragma mark -- 设置进度 --
- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    [self setNeedsDisplay];
}

#pragma mark -- 进度条背景颜色 --
- (void)setFillColor:(UIColor *)fillColor {
    _fillColor = fillColor;
    [self setNeedsDisplay];
}

#pragma mark -- 主色调,进度条颜色 --
- (void)setMainColor:(UIColor *)mainColor {
    _mainColor = mainColor;
    [self setNeedsDisplay];
}

#pragma mark -- 线宽 --
- (void)setLineWidth:(CGFloat)lineWidth
{
    _lineWidth = lineWidth;
    [self setNeedsDisplay];
}

#pragma mark -- 进度时间 --
- (void)setDuration:(CGFloat)duration
{
    _duration = duration;
    [self setNeedsDisplay];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
