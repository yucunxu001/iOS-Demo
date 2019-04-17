//
//  RACTupleViewController.m
//  MyReactiveCocoa
//
//  Created by mkrq-yh on 2019/4/9.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "RACTupleViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface RACTupleViewController ()

@end

@implementation RACTupleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"RACTuple元组基本使用";
    
    [self useRACTuple];
    [self useArray];
    [self useDictionary];
}

/*
 RACTuple:元组类,类似NSArray,用来包装值
 */
- (void)useRACTuple {
    RACTuple *tuple = [RACTuple tupleWithObjectsFromArray:@[@"123",@"456",@1]];
    NSString *first = tuple[0];
    NSLog(@"first==%@",first);
}

/*
 数组
 */
- (void)useArray {
    
    NSArray *array = @[@"aaa",@"bbb",@"ccc",@"ddd"];
    /*
    //RAC 集合
    RACSequence *sequence = array.rac_sequence;
    //把集合转换成信号
    RACSignal *signal = sequence.signal;
    //订阅集合信号,内部会自动遍历所有的元素发出来
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"x==%@",x);
    }];
    */
    
    //高级写法遍历数组
    [array.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"x==%@",x);
    }];
}

/*
 字典
 */
- (void)useDictionary {
    NSDictionary *dict = @{@"name":@"吊炸天",@"age":@"20",@"sex":@"男"};
    //转换成集合
    [dict.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        // RACTupleUnpack:用来解析元组
        // 宏里面的参数,传需要解析出来的变量名
        //= 右边,放需要解析的元组
        RACTupleUnpack(NSString *key, NSString *value) = x;
        NSLog(@"key==%@,value==%@",key,value);
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
