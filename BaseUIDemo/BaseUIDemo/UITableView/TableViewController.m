//
//  TableViewController.m
//  BaseUIDemo
//
//  Created by mkrq-yh on 2019/1/10.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation TableViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"%f",kScreenWidth);
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
