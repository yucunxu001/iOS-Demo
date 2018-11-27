//
//  ViewController.m
//  MasonryDemo
//
//  Created by mkrq-yh on 2018/11/20.
//  Copyright © 2018年 mkrq-yh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIView *oneView;
@property (nonatomic,strong) UIView *twoView;
@property (nonatomic,strong) UIView *threeView;
@property (nonatomic,strong) UILabel *textLb;

@property (nonatomic,strong) MASConstraint *topConstraint;

@property (nonatomic,assign) NSMutableArray *masonryViewArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"kScreenWidth==%f",kScreenWidth);
    NSLog(@"kScreenHeight==%f",kScreenHeight);
    [self initPage];
}

- (void)initPage
{
    self.view.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    self.bgView = [UIView new];
    self.bgView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.bgView];
    
//    [self.masonryViewArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:40 leadSpacing:20 tailSpacing:20];
//    [self.masonryViewArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:80 leadSpacing:20 tailSpacing:20];
//    [self.masonryViewArray mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).mas_offset(100);
//        make.height.mas_equalTo(80);
//    }];

//    [self.masonryViewArray mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:50 leadSpacing:50 tailSpacing:50];
    [self.masonryViewArray mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedItemLength:200 leadSpacing:40 tailSpacing:40];
    [self.masonryViewArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).mas_offset(20);
        make.width.mas_equalTo(200);
    }];
    
}

- (NSMutableArray *)masonryViewArray
{
    if (!_masonryViewArray) {
        _masonryViewArray = [NSMutableArray array];
        for (int i = 0; i < 4; i++) {
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = [UIColor greenColor];
            [_masonryViewArray addObject:view];
            [self.view addSubview:view];
        }
    }
    return _masonryViewArray;
}


@end
