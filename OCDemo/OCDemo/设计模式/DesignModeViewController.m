//
//  DesignModeViewController.m
//  OCDemo
//
//  Created by mkrq-yh on 2019/3/19.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "DesignModeViewController.h"
#import "KVOViewController.h"
#import "NotificationViewController.h"
#import "DelegateViewController.h"
#import "FactoryViewController.h"

@interface DesignModeViewController ()


@end

@implementation DesignModeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"设计模式";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(30, 50, self.view.frame.size.width-60, 50);
    [btn1 setTitle:@"KVO设计模式" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn1.titleLabel.font = [UIFont systemFontOfSize:16];
    btn1.backgroundColor = [UIColor greenColor];
    [btn1 addTarget:self action:@selector(kvoModeBtnLClick) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(30, btn1.frame.origin.y+btn1.frame.size.height+20, self.view.frame.size.width-60, 50);
    [btn2 setTitle:@"通知设计模式" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn2.titleLabel.font = [UIFont systemFontOfSize:16];
    btn2.backgroundColor = [UIColor greenColor];
    [btn2 addTarget:self action:@selector(notifiModeBtnLClick) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(30, btn2.frame.origin.y+btn2.frame.size.height+20, self.view.frame.size.width-60, 50);
    [btn3 setTitle:@"代理设计模式" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn3.titleLabel.font = [UIFont systemFontOfSize:16];
    btn3.backgroundColor = [UIColor greenColor];
    [btn3 addTarget:self action:@selector(delegateModeBtnLClick) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:btn3];
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.frame = CGRectMake(30, btn3.frame.origin.y+btn3.frame.size.height+20, self.view.frame.size.width-60, 50);
    [btn4 setTitle:@"工厂设计模式" forState:UIControlStateNormal];
    [btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn4.titleLabel.font = [UIFont systemFontOfSize:16];
    btn4.backgroundColor = [UIColor greenColor];
    [btn4 addTarget:self action:@selector(factoryModeBtnLClick) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:btn4];
    
}

- (void)kvoModeBtnLClick {
    KVOViewController *mode = [[KVOViewController alloc] init];
    [self.navigationController pushViewController:mode animated:true];
}

- (void)notifiModeBtnLClick {
    NotificationViewController *mode = [[NotificationViewController alloc] init];
    [self.navigationController pushViewController:mode animated:true];
}

- (void)delegateModeBtnLClick {
    DelegateViewController *mode = [[DelegateViewController alloc] init];
    [self.navigationController pushViewController:mode animated:true];
}

- (void)factoryModeBtnLClick {
    FactoryViewController *mode = [[FactoryViewController alloc] init];
    [self.navigationController pushViewController:mode animated:true];
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
