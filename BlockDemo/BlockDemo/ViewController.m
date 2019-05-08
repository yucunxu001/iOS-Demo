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
#import "Person.h"

#define WEAKSELF typeof(self) __weak weakSelf = self;

@interface ViewController ()

@property (nonatomic,strong) Person *person;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.person = [[Person alloc] init];
    void(^MyBlock)(void) = ^() {
        NSLog(@"block作为对象属性");
    };
    self.person.block = MyBlock;
    
    NSArray *array = @[@"无参无返",@"有参无返",@"有参有返",@"__block修饰",@"反向传值",@"对象属性",@"对象方法",@"方法参数",@"返回block",@"链式编程"];
    for (int i = 0; i < array.count; i++) {
        int x = i % 4;
        int y = i / 4;
        CGFloat width = (self.view.frame.size.width-100)/4;
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20+(width+20)*x, 100+70*y, width, 50)];
        btn.backgroundColor = [UIColor grayColor];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }

    
//    [self getData];
    /*
    returnType(^blockName)(parameterTypes) = ^(parameters) {
        statements
    };
    retuntype：返回值
    blockname：block的名字
    paramterType：参数类型
    parmeters：参数
    statements：要执行的代码
     */
}

#pragma mark -- block传参 --
- (void)btnClick:(UIButton *)sender
{
//    无参无返,有参无返,有参有返,__block修饰,反向传值
    switch (sender.tag) {
        case 0://无参无返
            [self useNoParamNoReturn];
            break;
        case 1://有参无返
            [self useHasParamNoReturn];
            break;
        case 2://有参有返
            [self useHasParamHasReturn];
            break;
        case 3://__block修饰
            [self use__block];
            break;
        case 4://反向传值
            [self useReverseValue];
            break;
        case 5://用做对象属性
            [self useObjectProperty];
            break;
        case 6://用做对象方法
            [self useObjectFunction];
            break;
        case 7://用做方法参数
            [self useFuncationParam];
            break;
        case 8://用做返回block
            [self useReturnBlock];
            break;
        case 9://用做链式编程
            [self useChainedMode];
            break;
            
        default:
            break;
    }
}

#pragma mark -- 无参数无返回值Block --
- (void)useNoParamNoReturn{
    void (^DemoBlock)(void) = ^ {
        NSLog(@"这是一个无参数无返回值的Block");
    };
    DemoBlock();
}
#pragma mark -- 有参数无返回值Block --
- (void)useHasParamNoReturn {
    void (^HasParam)(NSString *) = ^(NSString *name){
        NSLog(@"我的名字h叫%@",name);
    };
    HasParam(@"xxx");
}
#pragma mark -- 有参数有返回值Block --
- (void)useHasParamHasReturn {
//    __weak __typeof__(self) weakSelf = self;
    int (^AddNum)(int x,int y) = ^(int x,int y) {
        return x+y;
    };
    int z = AddNum(10,20);
    NSLog(@"z=%d",z);
    NSLog(@"AddNum==%@",AddNum);
}
#pragma mark -- __block修饰的block与不修饰的区别 --
- (void)use__block{
    //变量x在Block外定义的，在Block代码块编译的时候，取的x的值为之前的5(不可修改)。因此即使执行x += 5的使x的值变为10，但Block代码块里的x依然是5，所以block(5)的值为5+5=10。
    int x = 5;
    int (^Add)(int) = ^(int y){
        return x+y;
    };
    x = x + 5;
    NSLog(@"x==%d",x);
    NSLog(@"x+y==%d",Add(x));
    
    //在变量前添加__block关键字进行修饰后，此变量在Block代码块里的就是可更改的(可读可写)，执行代码时取变量最新的值。
    __block int m = 5;
    int (^Add2)(int) = ^(int n){
        return m+n;
    };
    m = m + 5;
    NSLog(@"m==%d",m);
    NSLog(@"Add2==%d",Add2(m));
}
#pragma mark -- 页面反向传值 --
- (void)useReverseValue {
    TwoViewController *two = [[TwoViewController alloc] init];
    two.changeName = ^(NSString * _Nonnull name) {
        NSLog(@"name==%@",name);
    };
    [self presentViewController:two animated:YES completion:nil];
}
#pragma mark -- 对象属性 --
- (void)useObjectProperty {
    NSLog(@"对象属性");
    self.person.block();
}
#pragma mark -- 对象方法 --
- (void)useObjectFunction {
    NSLog(@"对象方法");
    [self.person eatFoos:^(NSString * _Nonnull food) {
        NSLog(@"food==%@",food);
        
    }];
}

#pragma mark -- 方法参数 --
- (void)useFuncationParam
{
    [[HttpRequest sharedInstance] postWithUrl:@"userLogin" withParams:@{@"name":@"123456"} withSuccess:^(id  _Nonnull obj) {
        NSLog(@"obj==%@",obj);
    } withFailure:^(NSError * _Nonnull error) {
        NSLog(@"error==%@",error);
    }];
    
}

#pragma mark -- 返回blick --
- (void)useReturnBlock
{
    self.person.look();
    self.person.play(@"足球");
}

#pragma mark -- 链式编程 --
- (void)useChainedMode
{
    self.person.sleep(10).sleep(50).sleep(100).play(@"乒乓球");
}

@end
