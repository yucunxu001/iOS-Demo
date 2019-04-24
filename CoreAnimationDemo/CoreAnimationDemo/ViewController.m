//
//  ViewController.m
//  CoreAnimationDemo
//
//  Created by mkrq-yh on 2019/4/23.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "ViewController.h"
#import "BaseUseViewController.h"
#import "CABaseAnimationVC.h"
#import "CAAnimationGroupVC.h"
#import "CAKeyframeAnimationVC.h"
#import "CATransitionVC.h"
#import "DemoViewController.h"
#import "CASpringAnimationVC.h"


@interface ViewController ()

@property (nonatomic,strong) UIScrollView *scrollView;

@end

@implementation ViewController
{
    NSArray *data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    data = @[
             @"Core Animation基本使用",
             @"CABaseAnimation 基本使用",
             @"CAAnimationGroup 基本使用",
             @"CAKeyframeAnimationVC 基本使用",
             @"CATransitionVC 基本使用",
             @"不同的KeyPath的 基本使用",
             @"CASpringAnimationVC 基本使用",
             ];
    for (int i = 0; i < data.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame =  CGRectMake(20, 70*i+20, self.view.frame.size.width-40, 50);
        [btn setTitle:data[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor grayColor];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:btn];
    }
    
}

- (void)btnClick:(UIButton *)sender {
    if (sender.tag == 0) {
        BaseUseViewController *base = [BaseUseViewController new];
        [self.navigationController pushViewController:base animated:YES];
    } else if (sender.tag == 1) {
        CABaseAnimationVC *base = [CABaseAnimationVC new];
        [self.navigationController pushViewController:base animated:YES];
    } else if (sender.tag == 2) {
        CAAnimationGroupVC *base = [CAAnimationGroupVC new];
        [self.navigationController pushViewController:base animated:YES];
    } else if (sender.tag == 3) {
        CAKeyframeAnimationVC *base = [CAKeyframeAnimationVC new];
        [self.navigationController pushViewController:base animated:YES];
    } else if (sender.tag == 4) {
        CATransitionVC *base = [CATransitionVC new];
        [self.navigationController pushViewController:base animated:YES];
    } else if (sender.tag == 5) {
        DemoViewController *demo = [DemoViewController new];
        [self.navigationController pushViewController:demo animated:YES];
    } else if (sender.tag == 6) {
        CASpringAnimationVC *spring = [[CASpringAnimationVC alloc] init];
        [self.navigationController pushViewController:spring animated:YES];
    } else {
        
    }
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [self.view addSubview:self.scrollView];
    }
    return _scrollView;
}


@end
