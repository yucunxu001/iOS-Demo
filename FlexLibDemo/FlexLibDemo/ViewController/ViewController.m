//
//  ViewController.m
//  FlexLibDemo
//
//  Created by mkrq-yh on 2018/11/26.
//  Copyright © 2018 mkrq-yh. All rights reserved.
//

#import "ViewController.h"
#import "HomeViewController.h"
#import "FlexTableViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [UIButton new];
    btn.frame = CGRectMake(20, 100, kScreenWidth-40, 50);
    btn.backgroundColor = [UIColor greenColor];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setTitle:@"HomeFlex" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn2 = [UIButton new];
    btn2.frame = CGRectMake(20, 200, kScreenWidth-40, 50);
    btn2.backgroundColor = [UIColor greenColor];
    [btn2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn2 setTitle:@"TableFlex" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(btn2Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    
}

- (void)btnClick
{
    HomeViewController *home = [[HomeViewController alloc] init];
    [self.navigationController pushViewController:home animated:YES];
}

- (void)btn2Click
{
    FlexTableViewController *flextable = [[FlexTableViewController alloc] init];
    [self.navigationController pushViewController:flextable animated:YES];
}

@end
