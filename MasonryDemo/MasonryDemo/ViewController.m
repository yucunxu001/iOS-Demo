//
//  ViewController.m
//  MasonryDemo
//
//  Created by mkrq-yh on 2018/11/20.
//  Copyright © 2018年 mkrq-yh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self initPage];// view1边距20，view2边距50
    [self test1];
}

#pragma mark - view1边距20，view2边距50 -
- (void)initPage
{
    UIView *view1 = [UIView new];
    view1.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view1];
    
    UIView *view2 = [UIView new];
    view2.backgroundColor = [UIColor redColor];
    [view1 addSubview:view2];
    
    [view1 makeConstraints:^(MASConstraintMaker *make) {
        
//        make.top.equalTo(20);
//        make.bottom.equalTo(-20);
//        make.left.equalTo(20);
//        make.right.equalTo(-20);
        
//        make.top.left.equalTo(20);
//        make.right.bottom.equalTo(-20);
        
        make.edges.equalTo(UIEdgeInsetsMake(20, 20, 20, 20));
    }];
    
    [view2 makeConstraints:^(MASConstraintMaker *make) {
        
//        make.top.equalTo(50);
//        make.left.equalTo(50);
//        make.right.equalTo(-50);
//        make.bottom.equalTo(-50);
        
//        make.top.left.equalTo(50);
//        make.right.bottom.equalTo(-50);
        
        make.edges.equalTo(UIEdgeInsetsMake(50, 50, 50, 50));
    }];
}

- (void)test1 {
    UIView *redView = [[UIView alloc]init];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    
    UIView *blueView = [[UIView alloc]init];
    blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueView];
    
    UIView *yellowView = [[UIView alloc]init];
    yellowView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:yellowView];
    
    [redView makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    
    
}


@end
