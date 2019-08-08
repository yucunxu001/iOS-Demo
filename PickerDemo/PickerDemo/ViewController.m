//
//  ViewController.m
//  PickerDemo
//
//  Created by mkrq-yh on 2019/8/7.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "ViewController.h"
#import "TimeViewController.h"
#import "AddressViewController.h"
#import "CustomViewController.h"

#define ScreenW ([UIScreen mainScreen].bounds.size.width)
#define ScreenH ([UIScreen mainScreen].bounds.size.height)

@interface ViewController ()

@property (nonatomic,strong) UIButton *addressBtn;
@property (nonatomic,strong) UIButton *timeBtn;
@property (nonatomic,strong) UIButton *customBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    _addressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addressBtn.frame = CGRectMake(20, 100, ScreenW-40, 50);
    _addressBtn.backgroundColor = [UIColor greenColor];
    [_addressBtn setTitle:@"选择地址" forState:UIControlStateNormal];
    [_addressBtn addTarget:self action:@selector(showAddress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addressBtn];
    
    _timeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _timeBtn.frame = CGRectMake(20, 200, ScreenW-40, 50);
    _timeBtn.backgroundColor = [UIColor greenColor];
    [_timeBtn setTitle:@"选择时间" forState:UIControlStateNormal];
    [_timeBtn addTarget:self action:@selector(showTime) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_timeBtn];
    
    _customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _customBtn.frame = CGRectMake(20, 300, ScreenW-40, 50);
    _customBtn.backgroundColor = [UIColor greenColor];
    [_customBtn setTitle:@"选择自定义" forState:UIControlStateNormal];
    [_customBtn addTarget:self action:@selector(showCustom) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_customBtn];
    
}

#pragma mark - 选择地址 -
- (void)showAddress {
    NSLog(@"选择地址");
    [self.navigationController pushViewController:[AddressViewController new] animated:YES];
}

#pragma mark - 选择时间 -
- (void)showTime {
    NSLog(@"选择时间");
    [self.navigationController pushViewController:[TimeViewController new] animated:YES];
}

#pragma mark - 选择自定义 -
- (void)showCustom {
    NSLog(@"选择自定义");
    [self.navigationController pushViewController:[CustomViewController new] animated:YES];
}

@end
