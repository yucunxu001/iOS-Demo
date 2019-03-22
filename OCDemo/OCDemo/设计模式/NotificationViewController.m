//
//  NotificationViewController.m
//  OCDemo
//
//  Created by mkrq-yh on 2019/3/20.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "NotificationViewController.h"
#import "NotifyConst.h"

@interface NotificationViewController ()

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"通知";
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(30, 100, self.view.frame.size.width-60, 50);
    [btn2 setTitle:@"发送通知" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn2.titleLabel.font = [UIFont systemFontOfSize:16];
    btn2.backgroundColor = [UIColor greenColor];
    [btn2 addTarget:self action:@selector(notifiModeBtnLClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    //不传递参数
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(change) name:@"NoParam" object:nil];
    //使用object 传递消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeNotifi:) name:@"HasParam" object:nil];
    //使用userInfo 传递消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeUserInfo:) name:@"HasParamUserInfo" object:nil];
    
    NSLog(@"NotifyName1==%@",NotifyName1);
}


- (void)notifiModeBtnLClick {
    //不传递参数
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NoParam" object:nil];
    //使用object 传递消息
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HasParam" object:@"123456"];
    //使用userInfo 传递消息
    NSDictionary *dict = @{@"name":@"俞存旭",@"age":@"27",@"sex":@"男"};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HasParamUserInfo" object:nil userInfo:dict];

}

#pragma mark - 不传递参数回调
- (void)change {
    NSLog(@"不传递参数回调change");
}

#pragma mark - 使用object 传递消息
- (void)changeNotifi:(NSNotification *)notifi {
    NSDictionary *info = [notifi object];
    NSLog(@"传参回调==%@",info);
}

#pragma mark - 使用userInfo 传递消息
- (void)changeUserInfo:(NSNotification *)notifi {
    NSDictionary *info = [notifi userInfo];
    NSLog(@"使用userInfo传参回调==%@",[info objectForKey:@"name"]);
    NSLog(@"使用userInfo传参回调==%@",[info objectForKey:@"age"]);
    NSLog(@"使用userInfo传参回调==%@",[info objectForKey:@"sex"]);
}



- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
