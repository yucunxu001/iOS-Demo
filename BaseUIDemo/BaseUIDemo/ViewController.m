//
//  ViewController.m
//  BaseUIDemo
//
//  Created by mkrq-yh on 2019/1/9.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "ViewController.h"

#import "UIColor/ColorViewController.h"
#import "UITableView/TableViewController.h"
#import "UIImage/ImageViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = kColorWhite;
    scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight);
    [self.view addSubview:scrollView];
    
    if (@available(iOS 11.0, *)) {
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    CGFloat width = (kScreenWidth-60)/2;
    //颜色
    UIButton *colorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    colorBtn.frame = CGRectMake(10, BarHeight+20, width, 50);
    colorBtn.layer.borderWidth = 1;
    [colorBtn setTitle:@"颜色" forState:UIControlStateNormal];
    [colorBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    colorBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [colorBtn addTarget:self action:@selector(colorBtnCLick) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:colorBtn];
    
    //图片
    UIButton *imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    imageBtn.frame = CGRectMake(20+width, BarHeight+20, width, 50);
    imageBtn.layer.borderWidth = 1;
    [imageBtn setTitle:@"图片" forState:UIControlStateNormal];
    [imageBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    imageBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [imageBtn addTarget:self action:@selector(imageBtnCLick) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:imageBtn];
    
    //table
    UIButton *tableBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tableBtn.frame = CGRectMake(10, BarHeight+20+70, width, 50);
    tableBtn.layer.borderWidth = 1;
    [tableBtn setTitle:@"table" forState:UIControlStateNormal];
    [tableBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    tableBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [tableBtn addTarget:self action:@selector(tableBtnCLick) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:tableBtn];

    
}

#pragma mark - 颜色 -
- (void)colorBtnCLick
{
    ColorViewController *colorVC = [[ColorViewController alloc] init];
    [self.navigationController pushViewController:colorVC animated:YES];
}

#pragma mark - 图片 -
- (void)imageBtnCLick
{
    ImageViewController *imageVC = [[ImageViewController alloc] init];
    [self.navigationController pushViewController:imageVC animated:YES];
}

#pragma mark - table -
- (void)tableBtnCLick
{
    TableViewController *tableVC = [[TableViewController alloc] init];
    [self.navigationController pushViewController:tableVC animated:YES];
}


@end
