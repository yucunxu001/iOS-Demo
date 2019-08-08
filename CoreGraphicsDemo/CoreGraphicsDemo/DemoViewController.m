//
//  DemoViewController.m
//  CoreGraphicsDemo
//
//  Created by mkrq-yh on 2019/5/27.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "DemoViewController.h"
#import "LineView.h"
#import "EvenOddRuleView.h"
#import "ClipView.h"
#import "PatternView.h"

@interface DemoViewController ()

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.name;
    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    if ([self.type isEqualToString:@"0"]) {
        LineView *lineView = [[LineView alloc] initWithFrame:CGRectMake(20, 100, self.view.frame.size.width-40, 600)];
        lineView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:lineView];
    } else if ([self.type isEqualToString:@"1"]) {
        EvenOddRuleView *eoRuleView = [[EvenOddRuleView alloc] initWithFrame:CGRectMake(50, 100, 300, 300)];
        eoRuleView.backgroundColor = [UIColor greenColor];
        [self.view addSubview:eoRuleView];
    } else if ([self.type isEqualToString:@"2"]) {
        ClipView *clipView = [[ClipView alloc] initWithFrame:CGRectMake(50, 100, 300, 300)];
        clipView.backgroundColor = [UIColor greenColor];
        [self.view addSubview:clipView];
    } else if ([self.type isEqualToString:@"3"]) {
        //重复绘制
        PatternView *patternView = [[PatternView alloc] initWithFrame:CGRectMake(50, 100, 300, 300)];
//        patternView.backgroundColor = [UIColor redColor];
        [self.view addSubview:patternView];
    }

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
