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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
