//
//  RACSubscriberViewController.m
//  MyReactiveCocoa
//
//  Created by mkrq-yh on 2019/4/9.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "RACSubscriberViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "RedView.h"

@interface RACSubscriberViewController ()

@end

@implementation RACSubscriberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"RACSubscriber基本使用";
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 100, self.view.frame.size.width-40, 50);
    [btn setTitle:@"使用RACSubscriber创建信号" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor greenColor];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
//    RACSubscriber:
//        表示订阅者的意思，用于发送信号，这是一个协议，不是一个类，只要遵守这个协议，并且实现方法才能成为订阅者。通过create创建的信号，都有一个订阅者，帮助他发送数据。
//    RACDisposable:用于取消订阅或者清理资源，当信号发送完成或者发送错误的时候，就会自动触发它。
//        使用场景:不想监听某个信号时，可以通过它主动取消订阅信号。
//    RACSubject:RACSubject:信号提供者，自己可以充当信号，又能发送信号。
//        使用场景:通常用来代替代理，有了它，就不必要定义代理了。
//
//    RACReplaySubject:重复提供信号类，RACSubject的子类。
//        RACReplaySubject与RACSubject区别:
//        RACReplaySubject可以先发送信号，在订阅信号，RACSubject就不可以。
//        使用场景一:如果一个信号每被订阅一次，就需要把之前的值重复发送一遍，使用重复提供信号类。
//        使用场景二:可以设置capacity数量来限制缓存的value的数量,即只缓充最新的几个值。
    
    // RACSubject使用步骤
    // 1.创建信号 [RACSubject subject]，跟RACSiganl不一样，创建信号时没有block。
    // 2.订阅信号 - (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock
    // 3.发送信号 sendNext:(id)value
    
}

- (void)btnClick {
//    [self useRACSubject];
//    [self useRACReplaySubject];
    [self replaceDelegate];
}

#pragma mark - 使用RACSubject信号
- (void)useRACSubject {
    // RACSubject使用步骤
    // 1.创建信号 [RACSubject subject]，跟RACSiganl不一样，创建信号时没有block。
    // 2.订阅信号 - (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock
    // 3.发送信号 sendNext:(id)value
    //1.创建信号
    RACSubject *subject = [RACSubject subject];
    //订阅
    [subject subscribeNext:^(id  _Nullable x) {
        //当信号发出新值，就会调用.
        NSLog(@"RACSubject第一个订阅者%@",x);
    }];
    [subject subscribeNext:^(id  _Nullable x) {
        //当信号发出新值，就会调用.
        NSLog(@"RACSubject第二个订阅者%@",x);
    }];
    //3.发送信号
    [subject sendNext:@"123456"];
    //4.发送信号完成,内部会自动取消订阅者
    [subject sendCompleted];
}

#pragma mark - 使用RACSubject信号
- (void)useRACReplaySubject {
    // RACReplaySubject使用步骤:
    // 1.创建信号 [RACSubject subject]，跟RACSiganl不一样，创建信号时没有block。
    // 2.可以先订阅信号，也可以先发送信号。
    // 2.1 订阅信号 - (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock
    // 2.2 发送信号 sendNext:(id)value
    
    // RACReplaySubject:底层实现和RACSubject不一样。
    // 1.调用sendNext发送信号，把值保存起来，然后遍历刚刚保存的所有订阅者，一个一个调用订阅者的nextBlock。
    // 2.调用subscribeNext订阅信号，遍历保存的所有值，一个一个调用订阅者的nextBlock
    
    //1.创建信号
    RACReplaySubject *replaySubject = [RACReplaySubject subject];
    //2.发送信号
    [replaySubject sendNext:@"1111"];
    [replaySubject sendNext:@"2222"];
    //3.订阅信号
    [replaySubject subscribeNext:^(id  _Nullable x) {
        NSLog(@"RACReplaySubject第一个订阅者接收到的数据%@",x);
    }];
    [replaySubject subscribeNext:^(id  _Nullable x) {
        NSLog(@"RACReplaySubject第二个订阅者接收到的数据%@",x);
    }];
}

#pragma mark - 使用RACSubject代替代理
- (void)replaceDelegate {
    RedView *redView = [[RedView alloc] initWithFrame:CGRectMake(20, 200, self.view.frame.size.width-40, 200)];
    [redView.btnClickSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"代理==%@",x);
    }];
    [self.view addSubview:redView];
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
