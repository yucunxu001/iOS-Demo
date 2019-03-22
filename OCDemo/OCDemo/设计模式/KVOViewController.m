//
//  KVOViewController.m
//  OCDemo
//
//  Created by mkrq-yh on 2019/3/20.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "KVOViewController.h"
#import "Person.h"

@interface KVOViewController ()

@property (nonatomic,strong) Person *person;

@end

@implementation KVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"KVO设计模式";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initPerson];
}

#pragma mark - 初始化Person
- (void)initPerson {
    self.person = [[Person alloc] init];
    self.person.name = @"俞存旭";
    
    //observer观察者 (观察self.view对象的属性的变化)
    //KeyPath: 被观察属性的名称
    //options: 观察属性的新值,旧值等的一些配置(枚举值)
    //context:上下文 可以为kvo的回调方法传值
    //这儿的self.view是被观察者
    //注册观察者(可以是多个)
    
    /*
     options: 有4个值，分别是：
     NSKeyValueObservingOptionOld 把更改之前的值提供给处理方法
     NSKeyValueObservingOptionNew 把更改之后的值提供给处理方法
     NSKeyValueObservingOptionInitial 把初始化的值提供给处理方法，一旦注册，立马就会调用一次。通常它会带有新值，而不会带有旧值。
     NSKeyValueObservingOptionPrior 分2次调用。在值改变之前和值改变之后。
     */
    [self.person addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"下划线" style:UIBarButtonItemStylePlain target:self action:@selector(oldAction)];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithTitle:@"点语法" style:UIBarButtonItemStylePlain target:self action:@selector(newAction)];
    
    self.navigationItem.rightBarButtonItems = @[item1,item2];
}

#pragma mark - 导航栏按钮方法(如果赋值没有通过setter方法或者是kvc,例如(_name = @"新值"),这个时候不会触发kvc的回调方法)
//通过下划线赋值(不会触发回调方法)
- (void)oldAction {
    [self.person changeName:@"张三"];
}

//通过点语法赋值
- (void)newAction {
    [self.person changeNameFromSetter:@"李四"];
}

#pragma mark - 观察者回调方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    id oldValue = [change objectForKey:NSKeyValueChangeOldKey];
    NSLog(@"oldValue==%@",oldValue);
    id newValue = [change objectForKey:NSKeyValueChangeNewKey];
    NSLog(@"newValue==%@",newValue);
    id kindValue = [change objectForKey:NSKeyValueChangeKindKey];
    NSLog(@"kindValue==%@",kindValue);
    id indexesValue = [change objectForKey:NSKeyValueChangeIndexesKey];
    NSLog(@"indexesValue==%@",indexesValue);
    id priorValue = [change objectForKey:NSKeyValueChangeNotificationIsPriorKey];
    NSLog(@"priorValue==%@",priorValue);
}

#pragma mark - 移除观察者
- (void)dealloc {
    [self.person removeObserver:self forKeyPath:@"name"];
    self.person = nil;
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
