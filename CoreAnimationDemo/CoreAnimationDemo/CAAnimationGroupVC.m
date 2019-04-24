//
//  CAAnimationGroupVC.m
//  CoreAnimationDemo
//
//  Created by mkrq-yh on 2019/4/23.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "CAAnimationGroupVC.h"
#import "animation.h"

@interface CAAnimationGroupVC ()

@property (nonatomic,strong) UIView *demoView;

@end

@implementation CAAnimationGroupVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"CAAnimationGroup 基本使用";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, 50, 50)];
    self.demoView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.demoView];
    
    NSArray *array = @[@"同时",@"连续"];
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
    if (sender.tag == 0) {
        [self meanwhileAnimation];
    } else if (sender.tag == 1){
        [self continuousAnimation];
    } else {
        
    }
}

#pragma mark - 同时
- (void)meanwhileAnimation {
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animationWithKeyPath:kCAPosition];
    animation1.values = @[
                          [NSValue valueWithCGPoint:CGPointMake(self.demoView.center.x, self.demoView.center.y)],
                          [NSValue valueWithCGPoint:CGPointMake(self.demoView.center.x+100, self.demoView.center.y)],
                          [NSValue valueWithCGPoint:CGPointMake(self.demoView.center.x+100, self.demoView.center.y+100)],
                          [NSValue valueWithCGPoint:CGPointMake(self.demoView.center.x+200, self.demoView.center.y+100)],
                          [NSValue valueWithCGPoint:CGPointMake(self.demoView.center.x+200, self.demoView.center.y)],
                          [NSValue valueWithCGPoint:CGPointMake(self.demoView.center.x+300, self.demoView.center.y)],
                          ];
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:kCAScale];
    animation2.fromValue = @(1);
    animation2.toValue = @(3);
    
    CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:kCARotationZ];
    animation3.toValue = [NSNumber numberWithFloat:M_PI*2];

    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[animation1,animation2,animation3];
    group.duration = 4;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    
    [self.demoView.layer addAnimation:group forKey:@"groupAnimation"];
    
    
}

#pragma mark - 连续
- (void)continuousAnimation {
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animationWithKeyPath:kCAPosition];
    animation1.values = @[
                          [NSValue valueWithCGPoint:CGPointMake(self.demoView.center.x, self.demoView.center.y)],
                          [NSValue valueWithCGPoint:CGPointMake(self.demoView.center.x+100, self.demoView.center.y)],
                          [NSValue valueWithCGPoint:CGPointMake(self.demoView.center.x+100, self.demoView.center.y+100)],
                          [NSValue valueWithCGPoint:CGPointMake(self.demoView.center.x+200, self.demoView.center.y+100)],
                          [NSValue valueWithCGPoint:CGPointMake(self.demoView.center.x+200, self.demoView.center.y)],
                          [NSValue valueWithCGPoint:CGPointMake(self.demoView.center.x+300, self.demoView.center.y)],
                          ];
    animation1.duration = 1;
    animation1.beginTime = CACurrentMediaTime()+1;
    animation1.fillMode = kCAFillModeForwards;
    animation1.removedOnCompletion = NO;
    [self.demoView.layer addAnimation:animation1 forKey:@"Animation1"];

    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:kCAScale];
    animation2.fromValue = @(1);
    animation2.toValue = @(3);
    animation2.duration = 1;
    animation2.beginTime = CACurrentMediaTime()+2;
    animation2.fillMode = kCAFillModeForwards;
    animation2.removedOnCompletion = NO;
    [self.demoView.layer addAnimation:animation2 forKey:@"Animation2"];

    CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:kCARotationZ];
    animation3.toValue = [NSNumber numberWithFloat:M_PI*2];
    animation3.duration = 1;
    animation3.beginTime = CACurrentMediaTime()+3;
    animation3.fillMode = kCAFillModeForwards;
    animation3.removedOnCompletion = NO;
    [self.demoView.layer addAnimation:animation3 forKey:@"Animation3"];

    
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
