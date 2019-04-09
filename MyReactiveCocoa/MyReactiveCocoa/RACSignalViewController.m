//
//  RACSignalViewController.m
//  MyReactiveCocoa
//
//  Created by mkrq-yh on 2019/4/9.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "RACSignalViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface RACSignalViewController ()

@property (nonatomic, strong) id<RACSubscriber> subscriber;

@end

@implementation RACSignalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"RACSignal基本使用";
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 100, self.view.frame.size.width-40, 50);
    [btn setTitle:@"使用RACSignal创建信号" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor greenColor];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    

}

- (void)btnClick {
    [self createSignal];
    [self createGlobalSignal];
}

#pragma mark - 一般信号
- (void)createSignal {
    //三步骤:创建信号,订阅信号,发送信号
    //1.创建
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        //3.发送信号
        [subscriber sendNext:@"123456"];
        //如果不在发送数据，最好发送信号完成，内部会自动调用[RACDisposable disposable]取消订阅信号
        [subscriber sendCompleted];
        
        //取消订阅方法
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"默认信号发送完毕被取消");
        }];
    }];
    
    //2.订阅
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅信号:%@",x);
    }];
}

#pragma mark - 全局信号
- (void)createGlobalSignal {
//    //三步骤:创建信号,订阅信号,发送信号
    __weak typeof(self) weakSelf = self;
    RACSignal *signal1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        /**
         有一个全局变量保存值就不会走下面取消订阅方法
         */
        weakSelf.subscriber = subscriber;
        //3.发送信号
        [subscriber sendNext:@"123456"];
        //如果不在发送数据，最好发送信号完成，内部会自动调用[RACDisposable disposable]取消订阅信号
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"走销毁这个方法了");
        }];
    }];
    
    //订阅信号返回RACDisposable
    RACDisposable *disposable = [signal1 subscribeNext:^(id x) {
        NSLog(@"接收打印的值:%@",x);
    }];
    
    // 默认一个信号发送数据完毕们就会主动取消订阅.
    // 只要订阅者在,就不会自动取消信号订阅
    // 手动取消订阅者
    [disposable dispose];
    
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
