//
//  ViewController.m
//  OCDemo
//
//  Created by mkrq-yh on 2019/3/19.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "ViewController.h"
#import "DesignModeViewController.h"
#import "CountDownViewController.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface ViewController ()

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UILabel *timeLabel;

@end

@implementation ViewController
{
    dispatch_source_t _timer;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initPage];

}

- (void)initPage {
    [_scrollView removeFromSuperview];
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.contentSize = CGSizeMake(kScreenWidth, self.view.frame.size.height*2);
    [self.view addSubview:_scrollView];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(30, 50, kScreenWidth-60, 50);
    [btn1 setTitle:@"设计模式" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn1.titleLabel.font = [UIFont systemFontOfSize:16];
    btn1.backgroundColor = [UIColor greenColor];
    [btn1 addTarget:self action:@selector(designModeBtnLClick) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:btn1];
    
    UIButton *countDownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    countDownBtn.frame = CGRectMake(30, btn1.frame.origin.y+btn1.frame.size.height+20, kScreenWidth-60, 50);
    [countDownBtn setTitle:@"倒计时" forState:UIControlStateNormal];
    [countDownBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    countDownBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    countDownBtn.backgroundColor = [UIColor greenColor];
    [countDownBtn addTarget:self action:@selector(countDownBtnLClick) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:countDownBtn];



}

#pragma mark -设计模式-
- (void)designModeBtnLClick {
    NSLog(@"设计模式");
    DesignModeViewController *mode = [[DesignModeViewController alloc] init];
    [self.navigationController pushViewController:mode animated:true];
}
#pragma mark -倒计时"-
- (void)countDownBtnLClick {
    NSLog(@"倒计时");
    CountDownViewController *mode = [[CountDownViewController alloc] init];
    [self.navigationController pushViewController:mode animated:true];
}


@end
