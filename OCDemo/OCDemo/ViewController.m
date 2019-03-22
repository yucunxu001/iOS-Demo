//
//  ViewController.m
//  OCDemo
//
//  Created by mkrq-yh on 2019/3/19.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "ViewController.h"
#import "DesignModeViewController.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface ViewController ()

@property (nonatomic,strong) UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initPage];

}

- (void)initPage {
    [_scrollView removeFromSuperview];
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_scrollView];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(30, 50, kScreenWidth-60, 50);
    [btn1 setTitle:@"设计模式" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn1.titleLabel.font = [UIFont systemFontOfSize:16];
    btn1.backgroundColor = [UIColor greenColor];
    [btn1 addTarget:self action:@selector(designModeBtnLClick) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:btn1];

    UIView * view2 = [[UIView alloc] initWithFrame:CGRectMake(100, 300, 100, 100)];
    view2.backgroundColor = UIColor.redColor;
    [self.view addSubview:view2];

}

#pragma mark -设计模式-
- (void)designModeBtnLClick {
    NSLog(@"设计模式");
    DesignModeViewController *mode = [[DesignModeViewController alloc] init];
    [self.navigationController pushViewController:mode animated:true];
}

@end
