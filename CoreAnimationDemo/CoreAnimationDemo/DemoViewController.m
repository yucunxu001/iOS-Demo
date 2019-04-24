//
//  DemoViewController.m
//  CoreAnimationDemo
//
//  Created by mkrq-yh on 2019/4/23.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "DemoViewController.h"
#import "animation.h"
#import "AnimationDelegate.h"

@interface DemoViewController ()<CAAnimationDelegate>

@property (nonatomic,strong) UIImageView *demoImgView;

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Demo";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.demoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    [self.demoImgView setImage:[UIImage imageNamed:@"123"]];
    self.demoImgView.backgroundColor = [UIColor greenColor];
    self.demoImgView.center = self.view.center;
    [self.demoImgView.layer setShadowOffset:CGSizeMake(2,2)];
    [self.demoImgView.layer setShadowOpacity:1];
    [self.demoImgView.layer setShadowColor:[UIColor grayColor].CGColor];
    [self.view addSubview:self.demoImgView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =  CGRectMake(20, 600, self.view.frame.size.width-40, 50);
    [btn setTitle:@"开始" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

- (void)btnClick {
    
//    //旋转x
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:kCARotationX];
//    animation.fromValue = [NSNumber numberWithFloat:0];
//    animation.toValue = [NSNumber numberWithFloat:M_PI];
//    animation.duration = 2;
//    animation.repeatCount = 1;
//    animation.fillMode = kCAFillModeForwards;
//    animation.removedOnCompletion = NO;
//    [self.demoImgView.layer addAnimation:animation forKey:@""];
//
//    //旋转y
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:kCARotationY];
//    animation.fromValue = [NSNumber numberWithFloat:0];
//    animation.toValue = [NSNumber numberWithFloat:M_PI];
//    animation.duration = 2;
//    animation.repeatCount = 1;
//    animation.fillMode = kCAFillModeForwards;
//    animation.removedOnCompletion = NO;
//    [self.demoImgView.layer addAnimation:animation forKey:@""];
//
//    //缩放
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:kCAScale];
//    animation.fromValue = [NSNumber numberWithFloat:1];
//    animation.toValue = [NSNumber numberWithFloat:0.5];
//    animation.duration = 2;
//    animation.repeatCount = 1;
//    animation.fillMode = kCAFillModeForwards;
//    animation.removedOnCompletion = NO;
//    [self.demoImgView.layer addAnimation:animation forKey:@""];
//
//    //缩放x
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:kCAScaleX];
//    animation.fromValue = [NSNumber numberWithFloat:1];
//    animation.toValue = [NSNumber numberWithFloat:0.5];
//    animation.duration = 2;
//    animation.repeatCount = 1;
//    animation.fillMode = kCAFillModeForwards;
//    animation.removedOnCompletion = NO;
//    [self.demoImgView.layer addAnimation:animation forKey:@""];
//
//    //缩放y
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:kCAScaleY];
//    animation.fromValue = [NSNumber numberWithFloat:1];
//    animation.toValue = [NSNumber numberWithFloat:0.5];
//    animation.duration = 2;
//    animation.repeatCount = 1;
//    animation.fillMode = kCAFillModeForwards;
//    animation.removedOnCompletion = NO;
//    [self.demoImgView.layer addAnimation:animation forKey:@""];
//
//    //平移
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:kCATranslation];
//    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
//    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
//    animation.duration = 2;
//    animation.repeatCount = 1;
//    animation.fillMode = kCAFillModeForwards;
//    animation.removedOnCompletion = NO;
//    [self.demoImgView.layer addAnimation:animation forKey:@""];
//
//    //平移x
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:kCATranslationX];
//    animation.fromValue = [NSNumber numberWithFloat:0];
//    animation.toValue = [NSNumber numberWithFloat:100];
//    animation.duration = 2;
//    animation.repeatCount = 1;
//    animation.fillMode = kCAFillModeForwards;
//    animation.removedOnCompletion = NO;
//    [self.demoImgView.layer addAnimation:animation forKey:@""];
//
//    //平移y
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:kCATranslationY];
//    animation.fromValue = [NSNumber numberWithFloat:0];
//    animation.toValue = [NSNumber numberWithFloat:100];
//    animation.duration = 2;
//    animation.repeatCount = 1;
//    animation.fillMode = kCAFillModeForwards;
//    animation.removedOnCompletion = NO;
//    [self.demoImgView.layer addAnimation:animation forKey:@""];
//
//
//    //平面平移
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:kCAPosition];
//    animation.fromValue = [NSValue valueWithCGPoint:self.demoImgView.center];
//    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.demoImgView.center.x+100, self.demoImgView.center.y+100)];
//    animation.duration = 2;
//    animation.repeatCount = 1;
//    animation.fillMode = kCAFillModeForwards;
//    animation.removedOnCompletion = NO;
//    [self.demoImgView.layer addAnimation:animation forKey:@""];
//
//    //平面平移x
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:kCAPositionX];
//    animation.fromValue = [NSNumber numberWithFloat:self.demoImgView.center.x];
//    animation.toValue = [NSNumber numberWithFloat:self.demoImgView.center.x+100];
//    animation.duration = 2;
//    animation.repeatCount = 1;
//    animation.fillMode = kCAFillModeForwards;
//    animation.removedOnCompletion = NO;
//    [self.demoImgView.layer addAnimation:animation forKey:@""];
//
//    //平面平移y
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:kCAPositionY];
//    animation.fromValue = [NSNumber numberWithFloat:self.demoImgView.center.y];
//    animation.toValue = [NSNumber numberWithFloat:self.demoImgView.center.y+100];
//    animation.duration = 2;
//    animation.repeatCount = 1;
//    animation.fillMode = kCAFillModeForwards;
//    animation.removedOnCompletion = NO;
//    [self.demoImgView.layer addAnimation:animation forKey:@""];
//
//    //bounds origin没有用，设置size
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:kCABounds];
//    animation.fromValue = [NSValue valueWithCGRect:CGRectMake(0,0,100,100)];
//    animation.toValue = [NSValue valueWithCGRect:CGRectMake(0,0,200,200)];
//    animation.byValue  = [NSValue valueWithCGRect:self.demoImgView.bounds];
//    animation.duration = 2;
//    animation.repeatCount = 1;
//    animation.fillMode = kCAFillModeForwards;
//    animation.removedOnCompletion = NO;
//    [self.demoImgView.layer addAnimation:animation forKey:@""];
//
//    //bounds
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:kCABoundsSize];
//    animation.fromValue = [NSValue valueWithCGSize:self.demoImgView.bounds.size];
//    animation.toValue = [NSValue valueWithCGSize:CGSizeMake(200, 200)];
//    animation.duration = 2;
//    animation.repeatCount = 1;
//    animation.fillMode = kCAFillModeForwards;
//    animation.removedOnCompletion = NO;
//    [self.demoImgView.layer addAnimation:animation forKey:@""];
//
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:kCABoundsSizeW];
//    animation.fromValue = [NSNumber numberWithFloat:self.demoImgView.bounds.size.width];
//    animation.toValue = [NSNumber numberWithFloat:200];
//    animation.duration = 2;
//    animation.repeatCount = 1;
//    animation.fillMode = kCAFillModeForwards;
//    animation.removedOnCompletion = NO;
//    [self.demoImgView.layer addAnimation:animation forKey:@""];
//
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:kCABoundsSizeH];
//    animation.fromValue = [NSNumber numberWithFloat:self.demoImgView.bounds.size.height];
//    animation.toValue = [NSNumber numberWithFloat:200];
//    animation.duration = 2;
//    animation.repeatCount = 1;
//    animation.fillMode = kCAFillModeForwards;
//    animation.removedOnCompletion = NO;
//    [self.demoImgView.layer addAnimation:animation forKey:@""];
//
//    //透明
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:kCAOpacity];
//    animation.fromValue = [NSNumber numberWithFloat:1];
//    animation.toValue = [NSNumber numberWithFloat:0.3];
//    animation.duration = 2;
//    animation.repeatCount = 1;
//    animation.fillMode = kCAFillModeForwards;
//    animation.removedOnCompletion = NO;
//    [self.demoImgView.layer addAnimation:animation forKey:@""];
//
//    //背景色
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:kCABackgroundColor];
//    animation.fromValue = (__bridge id _Nullable)([UIColor greenColor].CGColor);
//    animation.toValue = (__bridge id _Nullable)([UIColor redColor].CGColor);
//    animation.duration = 2;
//    animation.repeatCount = 1;
//    animation.fillMode = kCAFillModeForwards;
//    animation.removedOnCompletion = NO;
//    [self.demoImgView.layer addAnimation:animation forKey:@"123"];
//
//    //圆角
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:kCACornerRadius];
//    animation.fromValue = [NSNumber numberWithFloat:0.f];
//    animation.toValue = [NSNumber numberWithFloat:20.f];
//    animation.duration = 2;
//    animation.repeatCount = 1;
//    animation.fillMode = kCAFillModeForwards;
//    animation.removedOnCompletion = NO;
//    [self.demoImgView.layer addAnimation:animation forKey:@"123"];
//
//    //内容
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:kCAContents];
//    animation.fromValue = (id)[UIImage imageNamed:@"123"].CGImage;
//    animation.toValue = (id)[UIImage imageNamed:@"456"].CGImage;
//    animation.duration = 2;
//    animation.repeatCount = 1;
//    animation.fillMode = kCAFillModeForwards;
//    animation.removedOnCompletion = NO;
//    [self.demoImgView.layer addAnimation:animation forKey:@"123"];
//
//    //阴影颜色
//    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"shadowColor"];
//    anim.duration = 1.f;
//    anim.toValue = (id)[UIColor redColor].CGColor;
//    anim.fromValue =  (id)[UIColor blackColor].CGColor;
//    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    anim.repeatCount = CGFLOAT_MAX;
//    anim.autoreverses = YES;
//    [self.demoImgView.layer addAnimation:anim forKey:nil];
//
//    //阴影偏移量
//    CABasicAnimation *_anim = [CABasicAnimation animationWithKeyPath:@"shadowOffset"];
//    _anim.duration = 1.f;
//    _anim.fromValue = [NSValue valueWithCGSize:CGSizeMake(0,0)];
//    _anim.toValue = [NSValue valueWithCGSize:CGSizeMake(3,3)];
//    _anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    _anim.repeatCount = CGFLOAT_MAX;
//    _anim.autoreverses = YES;
//    [self.demoImgView.layer addAnimation:_anim forKey:nil];
//
//    //阴影透明度
//    CABasicAnimation *_anim1 = [CABasicAnimation animationWithKeyPath:@"shadowOpacity"];
//    _anim1.duration = 1.f;
//    _anim1.fromValue = [NSNumber numberWithFloat:0.5];
//    _anim1.toValue = [NSNumber numberWithFloat:1];
//    _anim1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    _anim1.repeatCount = CGFLOAT_MAX;
//    _anim1.autoreverses = YES;
//    [self.demoImgView.layer addAnimation:_anim1 forKey:nil];
    
    //阴影范围大小
    CABasicAnimation *_anim2 = [CABasicAnimation animationWithKeyPath:@"shadowRadius"];
    _anim2.duration = 1.f;
    _anim2.fromValue = [NSNumber numberWithFloat:10];
    _anim2.toValue = [NSNumber numberWithFloat:5];
    _anim2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    _anim2.repeatCount = CGFLOAT_MAX;
    _anim2.autoreverses = YES;
    _anim2.delegate = self;
//    _anim2.delegate = [[AnimationDelegate alloc] init];
    [self.demoImgView.layer addAnimation:_anim2 forKey:nil];
    
}

#pragma mark - 动画开始时 -
- (void)animationDidStart:(CAAnimation *)anim {
    NSLog(@"开始了");
}

#pragma mark - 动画结束时 -
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"结束了");
    if ([anim isEqual:[self.demoImgView.layer animationForKey:@"123"]]) {
        NSLog(@"动画执行了");
    }
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
