//
//  CAKeyframeAnimationVC.m
//  CoreAnimationDemo
//
//  Created by mkrq-yh on 2019/4/23.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "CAKeyframeAnimationVC.h"
#import "animation.h"

@interface CAKeyframeAnimationVC ()

@property (nonatomic,strong) UIView *demoView;

@end

@implementation CAKeyframeAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"CAKeyframeAnimation 基本使用";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.demoView = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 50, 50)];
    self.demoView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.demoView];
    

    NSArray *array = @[@"关键帧",@"路径",@"抖动"];
    CGFloat width = (self.view.frame.size.width-100)/4;
    for (int i = 0; i < array.count; i++) {
        int x = i % 4;
        int y = i / 4;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame =  CGRectMake(20+x*(width+20), 600+y*70, width, 50);
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.backgroundColor = [UIColor grayColor];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }

}

- (void)btnClick:(UIButton *)sender {
    if (sender.tag == 0) {//关键帧
        [self setValuesAnimation];
    } else if (sender.tag == 1) {//路径
        [self setPathAnimation];
    } else if (sender.tag == 2) {//抖动
        [self setShake];
    } else {
        
    }
}

#pragma mark - 使用values 关键帧
- (void)setValuesAnimation
{
    /*
     calculationMode:
     kCAAnimationLinear 直线相连进行插值计算
     kCAAnimationDiscrete 离散，无中间过程，但keyTimes设置的时间依旧生效，物体跳跃地出现在各个关键帧上
     kCAAnimationPaced 动画以恒定速度运行，忽略keyTimes、timingFunctions
     kCAAnimationCubic 动画以恒定速度运行，忽略keyTimes、timingFunctions
     kCAAnimationCubicPaced 动画以恒定速度运行，忽略keyTimes、timingFunctions
     */
    
    CGPoint center = self.demoView.center;
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:kCAPosition];
    animation.duration = 4.0;
    animation.calculationMode = kCAAnimationLinear;
    animation.values = @[
                         [NSValue valueWithCGPoint:CGPointMake(center.x, center.y)],
                         [NSValue valueWithCGPoint:CGPointMake(center.x+100, center.y)],
                         [NSValue valueWithCGPoint:CGPointMake(center.x+100, center.y+100)],
                         [NSValue valueWithCGPoint:CGPointMake(center.x, center.y+100)],
                         [NSValue valueWithCGPoint:CGPointMake(center.x, center.y)]
                         ];
    animation.keyTimes = @[@(0),@(0.25),@(0.5),@(0.75),@(1)];
    animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
                                  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                                  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [self.demoView.layer addAnimation:animation forKey:@"ValuesAnimation"];
}

- (void)setPathAnimation
{
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGPathMoveToPoint(path, NULL, 0, 0);
//    CGPathAddLineToPoint(path, NULL, 200, 0);
//    CGPathAddLineToPoint(path, NULL, 200, 200);
//    CGPathAddLineToPoint(path, NULL, 0, 200);
//    CGPathAddLineToPoint(path, NULL, 0, 0);
//
//    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:kCATranslation];
//    anima.path = path;
//    anima.duration = 4.0;
//    anima.keyTimes = @[@(0.1),@(0.25),@(0.5),@(0.75),@(1)];
//    anima.timingFunctions = @[
//                              [CAMediaTimingFunction functionWithControlPoints:1 :0.5 :0.5 :0.5],
//                              [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
//                              [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
//                              [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]
//                              ];
//    //动画结束后保持动画最后的状态，两个属性需配合使用
//    anima.removedOnCompletion = NO;
//    anima.fillMode = kCAFillModeForwards;
//    CGPathRelease(path);
//    [self.demoView.layer addAnimation:anima forKey:@"PathAnimation"];
    
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.view.frame.size.width/2-100, self.view.frame.size.height/2-300, 200, 200)];
    anima.path = path.CGPath;
    anima.duration = 2.0f;
    [_demoView.layer addAnimation:anima forKey:@"pathAnimation"];

}

- (void)setShake {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];//在这里@"transform.rotation"==@"transform.rotation.z"
    NSValue *value1 = [NSNumber numberWithFloat:-M_PI/180*6];
    NSValue *value2 = [NSNumber numberWithFloat:M_PI/180*6];
    NSValue *value3 = [NSNumber numberWithFloat:-M_PI/180*6];
    animation.values = @[value1,value2,value3];
    animation.repeatCount = MAXFLOAT;
    [self.demoView.layer addAnimation:animation forKey:@"shakeAnimation"];
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
