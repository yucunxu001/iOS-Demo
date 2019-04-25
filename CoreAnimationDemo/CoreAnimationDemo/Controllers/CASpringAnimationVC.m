//
//  CASpringAnimationVC.m
//  CoreAnimationDemo
//
//  Created by mkrq-yh on 2019/4/24.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "CASpringAnimationVC.h"
#import "animation.h"

@interface CASpringAnimationVC ()

@property (nonatomic,strong) UIImageView *demoImgView;

@end

@implementation CASpringAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"CASpringAnimationVC 基本使用";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.demoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    //    [self.demoImgView setImage:[UIImage imageNamed:@"123"]];
    self.demoImgView.backgroundColor = [UIColor greenColor];
    self.demoImgView.center = self.view.center;
    [self.demoImgView.layer setShadowOffset:CGSizeMake(2,2)];
    [self.demoImgView.layer setShadowOpacity:1];
    [self.demoImgView.layer setShadowColor:[UIColor grayColor].CGColor];
    [self.view addSubview:self.demoImgView];
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame =  CGRectMake(20, 600, self.view.frame.size.width-40, 50);
//    [btn setTitle:@"开始" forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    btn.backgroundColor = [UIColor redColor];
//    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
    
}

- (void)btnClick {
    CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:kCABounds];
    animation.fromValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 100, 100)];
    animation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 200, 200)];
    animation.mass = 2;
    animation.stiffness = 100;
    animation.damping = 10;
    animation.initialVelocity = 5;
    animation.duration = animation.settlingDuration;
    //    animation.fillMode = kCAFillModeBoth;
    //    animation.removedOnCompletion = NO;
    [self.demoImgView.layer addAnimation:animation forKey:@""];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //获取触摸的所以对象；
    UITouch *touch = [touches anyObject];
    //获取点击的点；
    CGPoint point = [touch locationInView:self.view];
    NSLog(@"x==%f,y==%f",point.x,point.y);
    [self springAnimationTextAction:point];
}

#pragma mark iOS9 CASpringAnimation 弹簧动画
- (void)springAnimationTextAction:(CGPoint)point {
    CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"position.y"];
    
    if ([animation.keyPath isEqualToString:@"bounds"]) {
        animation.fromValue = [NSValue valueWithCGRect:self.demoImgView.frame];
        animation.toValue = [NSValue valueWithCGRect:CGRectMake(point.x, point.y, 50, 50)];
    } else if ([animation.keyPath isEqualToString:@"position"]) {
        animation.fromValue = [NSValue valueWithCGPoint:self.demoImgView.layer.position];
        animation.toValue = [NSValue valueWithCGPoint:point];
    } else if ([animation.keyPath isEqualToString:@"position.x"]) {
        animation.fromValue = [NSNumber numberWithFloat:self.demoImgView.layer.position.x];
        animation.toValue = [NSNumber numberWithFloat:point.x];
    } else if ([animation.keyPath isEqualToString:@"position.y"]) {
        animation.fromValue = [NSNumber numberWithFloat:self.demoImgView.layer.position.y];
        animation.toValue = [NSNumber numberWithFloat:point.y];
    }
    
    //质量，影响图层运动时的弹簧惯性，质量越大，弹簧拉伸和压缩的幅度越大 Defaults to 1
    animation.mass = 3;
    //刚度系数(劲度系数/弹性系数)，刚度系数越大，形变产生的力就越大，运动越快 Defaults to 100
    animation.stiffness = 100;
    //阻尼系数，阻止弹簧伸缩的系数，阻尼系数越大，停止越快 Defaults to 10
    animation.damping = 10;
    //初始速率，动画视图的初始速度大小 Defaults to zero
    //速率为正数时，速度方向与运动方向一致，速率为负数时，速度方向与运动方向相反
    animation.initialVelocity = 10;
    //估算时间 返回弹簧动画到停止时的估算时间，根据当前的动画参数估算
    animation.duration = animation.settlingDuration;
    
    [self.demoImgView.layer addAnimation:animation forKey:@"springAnimation"];
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
