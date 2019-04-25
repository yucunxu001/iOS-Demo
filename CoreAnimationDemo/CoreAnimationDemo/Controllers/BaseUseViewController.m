//
//  BaseUseViewController.m
//  CoreAnimationDemo
//
//  Created by mkrq-yh on 2019/4/23.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "BaseUseViewController.h"

@interface BaseUseViewController ()

@property (nonatomic,strong) UIView *demoView;

@end

@implementation BaseUseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Core Animation基本使用";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, 50, 50)];
    self.demoView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.demoView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =  CGRectMake(20, 100, self.view.frame.size.width-40, 50);
    [btn setTitle:@"开始" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

- (void)btnClick:(UIButton *)sender
{
//    [self useAnimation1];
//    [self useAnimation2];
    [self useAnimation3];
    
}

#pragma mark - 第一种：UIView 代码块调用 -
- (void)useAnimation1 {
    __weak typeof(self) weakSelf = self;
    
    [UIView animateWithDuration:3.0 animations:^{
        weakSelf.demoView.frame = CGRectMake(300, 200, 50, 50);
    }];
    
//    [UIView animateWithDuration:3.0 animations:^{
//        weakSelf.demoView.frame = CGRectMake(300, 200, 50, 50);
//    } completion:^(BOOL finished) {
//        weakSelf.demoView.backgroundColor = [UIColor redColor];
//    }];
//
//    [UIView animateWithDuration:3.0 delay:2.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        weakSelf.demoView.frame = CGRectMake(300, 200, 50, 50);
//    } completion:^(BOOL finished) {
//        weakSelf.demoView.backgroundColor = [UIColor redColor];
//    }];
}

#pragma mark - 第二种：UIView [begin commit]模式 -
- (void)useAnimation2 {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:3.0];
    [UIView setAnimationDelay:2.0];
    self.demoView.frame = CGRectMake(300, 200, 50, 50);
    [UIView commitAnimations];
}

#pragma mark - 第三种：使用Core Animation中的类 -
- (void)useAnimation3 {
    CABasicAnimation *base = [CABasicAnimation animationWithKeyPath:@"position"];
    base.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 200)];
    base.toValue = [NSValue valueWithCGPoint:CGPointMake(300, 200)];
    base.duration = 1.0;
    [self.demoView.layer addAnimation:base forKey:@"positionAnimation"];
    
    
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
