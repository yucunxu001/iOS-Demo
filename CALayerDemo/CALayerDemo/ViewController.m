//
//  ViewController.m
//  CALayerDemo
//
//  Created by mkrq-yh on 2019/5/9.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "ViewController.h"
#import "UIBezierPathViewController.h"

static CGFloat num;

@interface ViewController ()
@property (nonatomic,strong) CALayer *bgLayer;
@property (nonatomic,strong) CAShapeLayer *circle;
@property (nonatomic,strong) CADisplayLink *link;

@end

@implementation ViewController

@synthesize bgLayer;
@synthesize circle;

- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBar.hidden = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =  CGRectMake(20, 100, 100, 50);
    [btn setTitle:@"UIBezierPath" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor greenColor];
    [btn addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
//    [self demo];
//    [self demo1];
//    [self demo2];
//    [self demo3];
//    [self demo4];
//    [self demo5];
//    [self demo6];
//    [self demo7];
//    [self demoMask];
    [self demoMaskAndBezier];
    
}
//UIBezierPath使用
- (void)btnclick {
    UIBezierPathViewController *bezier = [UIBezierPathViewController new];
    [self.navigationController pushViewController:bezier animated:YES];
}

- (void)demo {
    
    CALayer *demoLayer = [CALayer layer];
    demoLayer.bounds = CGRectMake(0, 0, 100, 100);
    demoLayer.position = CGPointMake(100, 100);
    demoLayer.backgroundColor = [UIColor greenColor].CGColor;
    demoLayer.borderWidth = 2;
    demoLayer.borderColor = [UIColor redColor].CGColor;
    demoLayer.contents = (__bridge id)[UIImage imageNamed:@"123"].CGImage;
    demoLayer.contentsRect = CGRectMake(0.5, 0.5, 0.5, 0.5);
    demoLayer.cornerRadius = 20;
    demoLayer.doubleSided = NO;
//    demoLayer.hidden = YES;
//    demoLayer.masksToBounds = YES;
    demoLayer.opacity = 0.3;
    demoLayer.shadowColor = [UIColor yellowColor].CGColor;
    demoLayer.shadowOffset = CGSizeMake(10, 10);
    demoLayer.shadowRadius = 10;
    demoLayer.shadowOpacity = 0.6;
    [self.view.layer addSublayer:demoLayer];
}

- (void)demo1 {
    CALayer *redLayer = [CALayer layer];
    redLayer.bounds = CGRectMake(0, 0, 200, 200);
    redLayer.position = self.view.center;
    redLayer.backgroundColor = [[UIColor redColor] CGColor];
    
    
    UIBezierPath *apath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(20, 20, 60, 60)];

    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = apath.CGPath;
    maskLayer.fillColor = [[UIColor greenColor] CGColor];
    maskLayer.fillMode = kCAFillRuleEvenOdd;
    
    redLayer.mask = maskLayer;
    [self.view.layer addSublayer:redLayer];
}

- (void)demo2 {
    bgLayer = [CALayer layer];
    bgLayer.backgroundColor = [UIColor redColor].CGColor;
    bgLayer.bounds = CGRectMake(0, 0, self.view.frame.size.width, 200);
    bgLayer.position = self.view.center;
    
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.view.frame.size.width/2, 100) radius:20 startAngle:0 endAngle:2*M_PI clockwise:YES];
    
    circle = [CAShapeLayer layer];
    circle.path =circlePath.CGPath;
    circle.lineWidth = 5;
    circle.fillColor = [UIColor greenColor].CGColor;
    circle.fillRule  = kCAFillRuleEvenOdd;
    
    bgLayer.mask = circle;
    
    [self.view.layer addSublayer:bgLayer];
    
    //添加计时器
    self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(action)];
    [self.link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];

}

- (void)action {
    num = num + 1;
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.view.frame.size.width/2, 100) radius:20+num startAngle:0 endAngle:2*M_PI clockwise:YES];
    circle.path = circlePath.CGPath;
    if (num > 1000) {
        [self.link invalidate];
    }
}

#pragma mark - CAShapeLayer使用
- (void)demo3 {
    //设置矩形
//    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 100, 100)];
    //设置圆形
//    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 100, 100)];
    //设置自带圆角的路径
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 100, 100) cornerRadius:20];
    //指定矩形某一个角加圆角（代码示例为左上角）
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 100, 100) byRoundingCorners:UIRectCornerTopLeft cornerRadii:CGSizeMake(50, 50)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2-50, 100, 100);
    shapeLayer.path = path.CGPath;
    shapeLayer.backgroundColor = [UIColor yellowColor].CGColor;
    shapeLayer.fillColor = [UIColor greenColor].CGColor;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.masksToBounds = YES;
    [self.view.layer addSublayer:shapeLayer];
}

#pragma mark -配置贝塞尔曲线 正弦函数
- (void)demo4 {
    UIBezierPath *path1 = [self startPoint:CGPointMake(100, 300) endPoint:CGPointMake(200, 300) controlPoint:CGPointMake(150, 200)];
    CAShapeLayer *layer1 = [CAShapeLayer layer];
    layer1.path = path1.CGPath;
    layer1.fillColor = [UIColor greenColor].CGColor;
    layer1.strokeColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:layer1];
    
//    UIBezierPath *path2 = [self startPoint:CGPointMake(200, 300) endPoint:CGPointMake(300, 300) controlPoint:CGPointMake(250, 400)];
//    CAShapeLayer *layer2 = [CAShapeLayer layer];
//    layer2.path = path2.CGPath;
//    layer2.fillColor = [UIColor greenColor].CGColor;
//    layer2.strokeColor = [UIColor redColor].CGColor;
//    [self.view.layer addSublayer:layer2];
}
/**
 配置贝塞尔曲线
 @param startPoint 起始点
 @param endPoint 结束点
 @param controlPoint 控制点
 @return UIBezierPath对象
 */
- (UIBezierPath *)startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint controlPoint:(CGPoint)controlPoint
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:startPoint];
    [path addQuadCurveToPoint:endPoint controlPoint:controlPoint];
    
    return path;
}

#pragma mark - 直线 动画
- (void)demo5 {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(50, 300)];
    [path addLineToPoint:CGPointMake(100, 400)];
    [path addLineToPoint:CGPointMake(200, 300)];
    [path addLineToPoint:CGPointMake(50, 300)];

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 3;
    animation.fromValue = @(0);
    animation.toValue = @(1);
    animation.repeatCount = 1;
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.fillColor = [UIColor greenColor].CGColor;
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.lineWidth = 2;
    [self.view.layer addSublayer:layer];
    
    [layer addAnimation:animation forKey:@"strokeEndAnimation"];
    //注：由于UIBezierPath已经设置路径，所以动画的路径就不需要再次设置，只需要设置起始0与结束1就行，有需要可以设置动画结束后是否需要返回原位置。
}

#pragma mark - 三次贝塞尔曲线 动画
- (void)demo6 {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(100, 300)];
    [path addCurveToPoint:CGPointMake(300, 300) controlPoint1:CGPointMake(200, 200) controlPoint2:CGPointMake(200, 400)];

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 5;
    animation.fromValue = @(0);
    animation.toValue = @(1);

    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.lineWidth = 1;
    [self.view.layer addSublayer:layer];

    [layer addAnimation:animation forKey:@"123456"];
    
}
#pragma mark - 动画 圆
- (void)demo7 {
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 200, 200, 200)];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 5;
    animation.fromValue = @(0);
    animation.toValue = @(1);
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineWidth = 3;
    [self.view.layer addSublayer:layer];
    
    [layer addAnimation:animation forKey:@"yuan"];
}

#pragma mark - 使用mask
- (void)demoMask {
    CALayer *redLayer = [CALayer layer];
    redLayer.bounds = CGRectMake(0, 0, 200, 200);
    redLayer.backgroundColor = [UIColor redColor].CGColor;
    redLayer.position = CGPointMake(200, 300);
    [self.view.layer addSublayer:redLayer];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(50, 50, 100, 100)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = path.CGPath;
    maskLayer.fillColor = [UIColor greenColor].CGColor;
    
    redLayer.mask = maskLayer;
}

#pragma mark - 使用遮罩和UIBezierPath
- (void)demoMaskAndBezier {
//    UIBezierPath
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(30, 180, 340, 340)];
    bgView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:bgView];
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(50, 200, 300, 300);
    layer.contents = (__bridge id)[UIImage imageNamed:@"mask"].CGImage;
    [self.view.layer addSublayer:layer];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(150, 0)];
    [path addLineToPoint:CGPointMake(0, 200)];
    [path addQuadCurveToPoint:CGPointMake(300, 200) controlPoint:CGPointMake(150, 300)];
    [path closePath];

    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = path.CGPath;
    maskLayer.fillColor = [UIColor clearColor].CGColor;
    maskLayer.strokeColor = [UIColor redColor].CGColor;
    maskLayer.lineWidth = 30;
    
    layer.mask = maskLayer;
    
}

@end
