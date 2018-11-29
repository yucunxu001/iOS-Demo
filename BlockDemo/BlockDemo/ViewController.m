//
//  ViewController.m
//  BlockDemo
//
//  Created by mkrq-yh on 2018/11/29.
//  Copyright © 2018 mkrq-yh. All rights reserved.
//

#import "ViewController.h"
#import "TwoViewController.h"
#import "HttpRequest.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    //无参数无返回值block
    [self myBlockDemo1];
    //定义无返回值、有参数Block
    [self myBlockDemo2];
    //定义有返回值、有参数
    [self myBlockDemo3];
    //__block修饰的block与不修饰的区别
    [self myBlockDemo4];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 100, 200, 50)];
    btn.backgroundColor = [UIColor greenColor];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [self getData];
}

- (void)getData
{
    [[HttpRequest sharedInstance] postWithUrl:@"userLogin" withParams:@{@"name":@"123456"} withSuccess:^(id  _Nonnull obj) {
        NSLog(@"obj==%@",obj);
    } withFailure:^(NSError * _Nonnull error) {
        NSLog(@"error==%@",error);
    }];
    
}

#pragma mark -- block传参 --
- (void)btnClick
{
    TwoViewController *two = [[TwoViewController alloc] init];
    two.changeMsg = ^(NSString * _Nonnull msg) {
        NSLog(@"msg==%@",msg);
        self.view.backgroundColor = [UIColor redColor];
    };
    [self presentViewController:two animated:YES completion:nil];
}

#pragma mark -- 无参数无返回值block --
- (void)myBlockDemo1{
    void (^MyBlock)(void) = ^() {
        NSLog(@"无参数无返回值block");
    };
    MyBlock();
}

#pragma mark -- 定义无返回值、有参数Blockblock --
- (void)myBlockDemo2{
    //block中self弱引用
    __weak __typeof__(self) weakSelf = self;
    void (^MyBolock)(NSInteger) = ^(NSInteger num){
        weakSelf.view.backgroundColor = [UIColor greenColor];
        NSLog(@"定义无返回值、有参数==%ld",(long)num);
    };
    MyBolock(100);
}

#pragma mark -- 定义有返回值、有参数Blockblock --
- (void)myBlockDemo3{
    NSString *(^MyBolock)(NSDictionary *) = ^(NSDictionary *dict){
        NSString *name = [NSString stringWithFormat:@"%@",dict[@"name"]];
        NSLog(@"定义有返回值、有参数==%@",name);
        return name;
    };
    MyBolock(@{@"name":@"俞存旭"});
}

#pragma mark -- __block修饰的block与不修饰的区别 --
- (void)myBlockDemo4{
    int x = 5;
    int (^MyBlock)(int) = ^(int y){
        return x+y;
    };
    x = x+5;
    NSLog(@"x=%d",x);
    NSLog(@"x+y=%d",MyBlock(5));
    //变量x在Block外定义的，在Block代码块编译的时候，取的x的值为之前的5(不可修改)。因此即使执行x += 5的使x的值变为10，但Block代码块里的x依然是5，所以block(5)的值为5+5=10。
    /* 不使用__block修饰,x=10,x+y=10 */
    
    __block int m = 5;
    int (^MyBlock2)(int) = ^(int n){
        return m+n;
    };
    m = m+5;
    NSLog(@"m=%d",m);
    NSLog(@"m+n=%d",MyBlock2(5));
    //在变量前添加__block关键字进行修饰后，此变量在Block代码块里的就是可更改的(可读可写)，执行代码时取变量最新的值。
    /* 使用__block修饰 m=10,m+n=15 */
}

@end
