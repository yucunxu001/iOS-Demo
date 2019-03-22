//
//  DelegateViewController.m
//  OCDemo
//
//  Created by mkrq-yh on 2019/3/20.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "DelegateViewController.h"
#import "CustomView.h"

@interface DelegateViewController ()<CustomViewDelegate>

@end

@implementation DelegateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"代理";
    
    CustomView *custom = [[CustomView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 300) withVC:self];
    custom.delegate = self;
    [self.view addSubview:custom];
}

#pragma mark - 代理方法
- (void)selectedItemButton:(NSInteger)index {
    NSLog(@"代理方法==%ld",(long)index);
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
