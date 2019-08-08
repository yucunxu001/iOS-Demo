//
//  ViewController.m
//  ToastDemo
//
//  Created by mkrq-yh on 2019/8/1.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "ViewController.h"
#import "Toast.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(20, 100, 100, 40);
    [btn1 setTitle:@"显示弹框" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 setBackgroundColor:[UIColor grayColor]];
    [btn1 addTarget:self action:@selector(btnClick1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(20, 160, 100, 40);
    [btn2 setTitle:@"隐藏弹框" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn2 setBackgroundColor:[UIColor grayColor]];
    [btn2 addTarget:self action:@selector(btnClick2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
}

- (void)btnClick1 {
    NSLog(@"btnClick1");
//    //最基本
//    [self.view makeToast:@"This is a piece of toast."];
    
//    //定义位置
//    [self.view makeToast:@"这是一个Center提示" duration:3.0 position:CSToastPositionCenter];
//    [self.view makeToast:@"这是一个Top提示" duration:3.0 position:CSToastPositionTop];
//    [self.view makeToast:@"这是一个Bottom提示" duration:3.0 position:CSToastPositionBottom];
    
//    //带图片的弹框
//    CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
//    style.messageFont = [UIFont fontWithName:@"Zapfino" size:14.0];
//    style.messageColor = [UIColor redColor];
//    style.messageAlignment = NSTextAlignmentCenter;
//    style.backgroundColor = [UIColor yellowColor];
//    [self.view makeToast:@"这是一个登录成功提示" duration:3.0 position:CSToastPositionCenter title:@"登录成功" image:[UIImage imageNamed:@"success"] style:style completion:^(BOOL didTap) {
//        if (didTap) {
//            NSLog(@"点击弹框");
//        } else {
//            NSLog(@"没有点击弹框");
//        }
//    }];

//    // 显示旋转菊花activity
//    [self.view makeToastActivity:CSToastPositionCenter];
    
    UIView *toast = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 80)];
    toast.backgroundColor = [UIColor greenColor];
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 100, 40)];
    lable.text = @"哈哈哈";
    lable.textAlignment = NSTextAlignmentCenter;
    [toast addSubview:lable];
    [self.view showToast:toast duration:3.0 position:CSToastPositionCenter completion:^(BOOL didTap) {
        if (didTap) {
            NSLog(@"点击弹框");
        } else {
            NSLog(@"没有点击弹框");
        }
    }];
    
}

- (void)btnClick2 {
    //隐藏旋转菊花
    [self.view hideToastActivity];
}

@end
