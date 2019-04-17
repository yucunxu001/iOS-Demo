//
//  RACMethodViewController.m
//  MyReactiveCocoa
//
//  Created by mkrq-yh on 2019/4/10.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "RACMethodViewController.h"
#import <RACEXTScope.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "RedView.h"

@interface RACMethodViewController ()

@property (nonatomic,strong) UIScrollView *scrollView;

@end

@implementation RACMethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"RAC常用方法";
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*2);
    [self.view addSubview:_scrollView];
    
    //代替button点击事件
    [self useButton];
    //代替代理
    [self useReplaceDelegate];
    //rac_signalForSelector:监听某对象有没有调用某方法
    [self useSignalForSelector];
    //rac_valuesAndChangesForKeyPath
    [self useKVO];
    //代替通知
    [self useNotificationCenter];
    //处理多个信号
    [self useMoreSignal];
    
    
}

/*
 rac_signalForControlEvents 代替点击事件
 */
- (void)useButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, 100, self.view.frame.size.width-40, 50);
    button.backgroundColor = [UIColor greenColor];
    [button setTitle:@"代替button点击" forState:UIControlStateNormal];
    [_scrollView addSubview:button];
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"按钮被j点击了");
    }];
}

/*
 RACSubject
 代替代理
 */
- (void)useReplaceDelegate {
    
    RedView *redView = [[RedView alloc] initWithFrame:CGRectMake(20, 200, self.view.frame.size.width-40, 100)];
    [redView.btnClickSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"代替代理==%@",x);
    }];
    [_scrollView addSubview:redView];
}

/*
 rac_signalForSelector:监听某对象有没有调用某方法
 */
- (void)useSignalForSelector {
    // 把控制器调用didReceiveMemoryWarning转换成信号
    //rac_signalForSelector:监听某对象有没有调用某方法
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, 350, self.view.frame.size.width-40, 50);
    button.backgroundColor = [UIColor greenColor];
    [button setTitle:@"监听某对象有没有调用某方法" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:button];
    
    [[button rac_signalForSelector:@selector(setBackgroundColor:)] subscribeNext:^(id x) {
        NSLog(@"button调用了setBackgroundColor方法");
    }];
}

- (void)buttonClick:(UIButton *)sender {
    NSLog(@"哈哈哈哈");
    [sender setBackgroundColor:[UIColor redColor]];
}
/*
 代替KVO
 */
- (void)useKVO {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, 450, self.view.frame.size.width-40, 50);
    button.backgroundColor = [UIColor greenColor];
    [button setTitle:@"代替KVO" forState:UIControlStateNormal];
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        button.center = CGPointMake(button.center.x+10, button.center.y);
    }];
    [_scrollView addSubview:button];
    //使用rac_valuesAndChangesForKeyPath代替KVO
    [[button rac_valuesAndChangesForKeyPath:@"center" options:NSKeyValueObservingOptionNew observer:self] subscribeNext:^(RACTwoTuple<id,NSDictionary *> * _Nullable x) {
        NSLog(@"center==%@",x);
    }];
    
}

/*
 代替通知
 */
- (void)useNotificationCenter {
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 550, self.view.frame.size.width-40, 50)];
    textField.layer.borderWidth = 1;
    textField.placeholder = @"请输入";
    [textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"输入==%@",x);
    }];
    [_scrollView addSubview:textField];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSLog(@"键盘弹起");
    }];
}

/*处理多个请求*/
- (void)useMoreSignal {
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"111"];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"取消信号1");
        }];
    }];
    
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"222"];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"取消信号2");
        }];
    }];

    // 使用注意：几个信号，参数一的方法就几个参数，每个参数对应信号发出的数据。
    [self rac_liftSelector:@selector(dealSignalA:SignB:) withSignalsFromArray:@[signalA,signalB]];
    
}

- (void)dealSignalA:(id)data1 SignB:(id)data2 {
    NSLog(@"data1==%@,data2==%@",data1,data2);
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
