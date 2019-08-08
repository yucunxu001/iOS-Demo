//
//  ViewController.m
//  CoreGraphicsDemo
//
//  Created by mkrq-yh on 2019/5/27.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "ViewController.h"
#import "DemoViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSArray *nameArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;

    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    
    nameArray = @[@"画线条",@"奇偶原则选择性绘制",@"clip剪切",@"Pattern重复"];
    for (int i = 0; i < nameArray.count; i++) {
        UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        itemBtn.frame = CGRectMake(20, 50+80*i, self.view.frame.size.width-40, 60);
        [itemBtn setTitle:nameArray[i] forState:UIControlStateNormal];
        [itemBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        itemBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        itemBtn.backgroundColor = [UIColor grayColor];
        itemBtn.tag = i;
        [itemBtn addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:itemBtn];
    }
}

#pragma mark - 点击 画线条
- (void)itemBtnClick:(UIButton *)sender {
    NSString *type = @"";
    if (sender.tag == 0) {//画线条
        type = @"0";
    } else if (sender.tag == 1) {
        //使用even-odd rule奇偶原则选择性绘制，该原则简单理解就是画一条线横穿所有路径，奇数个路径需要填充
        type = @"1";
    } else if (sender.tag == 2) {
        //剪切
        type = @"2";
    } else if (sender.tag == 3) {
        //重复绘制
        type = @"3";
    }
    
    DemoViewController *demo = [DemoViewController new];
    demo.type = type;
    demo.name = nameArray[sender.tag];
    [self.navigationController pushViewController:demo animated:YES];
}


@end
