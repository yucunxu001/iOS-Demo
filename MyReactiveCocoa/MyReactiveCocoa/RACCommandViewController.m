//
//  RACCommandViewController.m
//  MyReactiveCocoa
//
//  Created by mkrq-yh on 2019/4/10.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "RACCommandViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface RACCommandViewController ()

@property (nonatomic, strong) RACCommand *command;

@end

@implementation RACCommandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"RACCommand基本使用";
//    [self useRACCommand];
//    [self switchToLatest];
    [self commandData];
}

- (void)useRACCommand {
    //RACCommand:RAC中用于处理事件的类，可以把事件如何处理,事件中的数据如何传递，包装到这个类中，他可以很方便的监控事件的执行过程。
    
    // 一、RACCommand使用步骤:
    // 1.创建命令 initWithSignalBlock:(RACSignal * (^)(id input))signalBlock
    // 2.在signalBlock中，创建RACSignal，并且作为signalBlock的返回值
    // 3.执行命令 - (RACSignal *)execute:(id)input
    
    // 二、RACCommand使用注意:
    // 1.signalBlock必须要返回一个信号，不能传nil.
    // 2.如果不想要传递信号，直接创建空的信号[RACSignal empty];
    // 3.RACCommand中信号如果数据传递完，必须调用[subscriber sendCompleted]，这时命令才会执行完毕，否则永远处于执行中。
    // 三、RACCommand设计思想：内部signalBlock为什么要返回一个信号，这个信号有什么用。
    // 1.在RAC开发中，通常会把网络请求封装到RACCommand，直接执行某个RACCommand就能发送请求。
    // 2.当RACCommand内部请求到数据的时候，需要把请求的数据传递给外界，这时候就需要通过signalBlock返回的信号传递了。

    // 四、如何拿到RACCommand中返回信号发出的数据。
    // 1.RACCommand有个执行信号源executionSignals，这个是signal of signals(信号的信号),意思是信号发出的数据是信号，不是普通的类型。
    // 2.订阅executionSignals就能拿到RACCommand中返回的信号，然后订阅signalBlock返回的信号，就能获取发出的值。
    
    // 五、监听当前命令是否正在执行executing
    
    // 六、使用场景,监听按钮点击，网络请求
    
    //1.创建命令
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"执行命令");
        //创建空信号,必须返回信号
        //return [RACSignal empty];
        
        //2.创建信号,用来传递数据
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:@"123"];
            //注意:数据传递完，最好调用sendCompleted，这时命令才执行完毕
            [subscriber sendCompleted];
            return [RACDisposable disposableWithBlock:^{
                NSLog(@"数据销毁");
            }];
        }];
    }];
    
    //强引用命令，不要被销毁，否则接收不到数据
    _command = command;
    
    //监听事件有没有完成
    [command.executing subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue] == YES) { // 当前正在执行
            NSLog(@"当前正在执行");
        }else{
            // 执行完成/没有执行
            NSLog(@"执行完成/没有执行");
        }
        
    }];
    //执行命令
    [self.command execute:@1];
}

// RAC高级用法
- (void)switchToLatest {
    RACSubject *signalOfSignals = [RACSubject subject];
    RACSubject *signalA = [RACSubject subject];
    RACSubject *signalB = [RACSubject subject];
    //switchToLatest:获取信号中信号发送的最新信号
    [signalOfSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"x==%@",x);
    }];
    
    // 发送信号
    [signalOfSignals sendNext:signalA];
    [signalA sendNext:@1];
    [signalB sendNext:@"BB"];
    [signalA sendNext:@"11"];
}

- (void)commandData
{
    // RACCommand:处理事件
    // RACCommand:不能返回一个空的信号
    // 1.创建命令
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        // input:执行命令传入参数
        // Block调用:执行命令的时候就会调用
        NSLog(@"input==%@",input);
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            // 发送数据
            [subscriber sendNext:@"执行命令产生的数据"];
            
            return nil;
        }];
    }];
    
    // 如何拿到执行命令中产生的数据
    // 订阅命令内部的信号
    // 1.方式一:直接订阅执行命令返回的信号
    // 2.方式二:
    
    // 2.执行命令
    RACSignal *signal = [command execute:@1];
    
    // 3.订阅信号
    [signal subscribeNext:^(id x) {
        NSLog(@"x==%@",x);
    }];
    
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
