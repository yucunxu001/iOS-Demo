//
//  CountDownViewController.m
//  OCDemo
//
//  Created by mkrq-yh on 2019/3/22.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "CountDownViewController.h"
#import "CountDownGCDViewController.h"
#import "CountDownNSTimerViewController.h"

@interface CountDownViewController ()

@end

@implementation CountDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationItem.title = @"倒计时";
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(30, 100, self.view.frame.size.width-60, 50);
    [btn1 setTitle:@"GCD倒计时" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn1.titleLabel.font = [UIFont systemFontOfSize:16];
    btn1.backgroundColor = [UIColor greenColor];
    [btn1 addTarget:self action:@selector(gcdBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(30, 200, self.view.frame.size.width-60, 50);
    [btn2 setTitle:@"NSTimer倒计时" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn2.titleLabel.font = [UIFont systemFontOfSize:16];
    btn2.backgroundColor = [UIColor greenColor];
    [btn2 addTarget:self action:@selector(timerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
}

- (void)gcdBtnClick {
    CountDownGCDViewController *gcd = [[CountDownGCDViewController alloc] init];
    [self.navigationController pushViewController:gcd animated:true];
}

- (void)timerBtnClick {
    CountDownNSTimerViewController *gcd = [[CountDownNSTimerViewController alloc] init];
    [self.navigationController pushViewController:gcd animated:true];
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
