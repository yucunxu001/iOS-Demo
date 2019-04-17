//
//  RACMulticastConnectionViewController.m
//  MyReactiveCocoa
//
//  Created by mkrq-yh on 2019/4/10.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "RACMulticastConnectionViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface RACMulticastConnectionViewController ()

@end

@implementation RACMulticastConnectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"RACMulticastConnection基本使用";
    [self useRACMulticastConnection];
}

- (void)useRACMulticastConnection {
//    RACMulticastConnection:用于当一个信号，被多次订阅时，为了保证创建信号时，避免多次调用创建信号中的block，造成副作用，可以使用这个类处理。
//    使用注意:RACMulticastConnection通过RACSignal的-publish或者-muticast:方法创建.
//    RACMulticastConnection简单使用:
//    RACMulticastConnection使用步骤:
//    1.创建信号 + (RACSignal *)createSignal:(RACDisposable * (^)(id<RACSubscriber> subscriber))didSubscribe
//    2.创建连接 RACMulticastConnection *connect = [signal publish];
//    3.订阅信号,注意：订阅的不在是之前的信号，而是连接的信号。 [connect.signal subscribeNext:nextBlock]
//    4.连接 [connect connect]
//
//    RACMulticastConnection底层原理:
//    1.创建connect，connect.sourceSignal -> RACSignal(原始信号)  connect.signal -> RACSubject
//    2.订阅connect.signal，会调用RACSubject的subscribeNext，创建订阅者，而且把订阅者保存起来，不会执行block。
//    3.[connect connect]内部会订阅RACSignal(原始信号)，并且订阅者是RACSubject
//    3.1.订阅原始信号，就会调用原始信号中的didSubscribe
//    3.2 didSubscribe，拿到订阅者调用sendNext，其实是调用RACSubject的sendNext
//    4.RACSubject的sendNext,会遍历RACSubject所有订阅者发送信号。
//    4.1 因为刚刚第二步，都是在订阅RACSubject，因此会拿到第二步所有的订阅者，调用他们的nextBlock
//    需求：假设在一个信号中发送请求，每次订阅一次都会发送请求，这样就会导致多次请求。
//    解决：使用RACMulticastConnection就能解决.
    
    //1.创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"发送请求");
        [subscriber sendNext:@"111"];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"走销毁这个方法了");
        }];
    }];
    //3.订阅信号
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"signal接收数据11==%@",x);
    }];
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"signal接收数据22==%@",x);
    }];
    // 3.运行结果，会执行两遍发送请求，也就是每次订阅都会发送一次请求

    
    // RACMulticastConnection:解决重复请求问题
    //1.创建信号
    RACSignal *connectionSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"发送请求22");
        [subscriber sendNext:@"222"];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"走销毁这个方法了22");
        }];;
    }];
    //2.创建连接
    RACMulticastConnection *connection = [connectionSignal publish];
    //3.订阅信号
    [connection.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅者一==%@",x);
    }];
    [connection.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅者二==%@",x);
    }];
    //4.连接,激活信号
    [connection connect];
    
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
