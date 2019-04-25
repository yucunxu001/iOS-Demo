//
//  DemoViewController.m
//  CoreAnimationDemo
//
//  Created by mkrq-yh on 2019/4/23.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "DemoViewController.h"
#import "animation.h"
#import "DWMenuButton.h"
#import "TouchView.h"

@interface DemoViewController ()

@property (nonatomic,strong) UIButton *homeBtn;

@end

@implementation DemoViewController
{
    NSArray *titleArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Demo";
    self.view.backgroundColor = [UIColor whiteColor];

//    DWMenuButton *menuBtn = [[DWMenuButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-100, 600, self.homeBtn.frame.size.width, self.homeBtn.frame.size.width) withDirection:DirectionUp];
//    menuBtn.homeButtonView = self.homeBtn;
//    [menuBtn addButtons:[self createButtonArray]];
//    menuBtn.time = 0.3;
//    menuBtn.buttonSpacing = 10;
//    [self.view addSubview:menuBtn];
    
    TouchView *v1 = [[TouchView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-100, 600, self.homeBtn.frame.size.width, self.homeBtn.frame.size.width)];
//    v1.homeButtonView = self.homeBtn;
    v1.backgroundColor = [UIColor grayColor];
    [self.view addSubview:v1];
    
    
}
                                                                                       
- (NSArray *)createButtonArray {
    titleArray = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G"];
    NSMutableArray *buttonArray = [[NSMutableArray alloc] init];
    int i = 0;
    for (NSString *titleStr in titleArray) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame =  CGRectMake(0, 0, 40, 40);
        [btn setTitle:titleStr forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        btn.backgroundColor = [UIColor grayColor];
        btn.tag = i;
        btn.layer.cornerRadius = btn.frame.size.height/2;
        btn.layer.masksToBounds = YES;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [buttonArray addObject:btn];
        i++;
    }
    return [buttonArray copy];
}

- (void)btnClick:(UIButton *)sender {
    NSLog(@"%@",titleArray[sender.tag]);
}

- (UIButton *)homeBtn {
    if (!_homeBtn) {
        self.homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.homeBtn.frame = CGRectMake(0, 0,  50, 50);
        self.homeBtn.backgroundColor = [UIColor redColor];
        [self.homeBtn setTitle:@"Tap" forState:UIControlStateNormal];
        [self.homeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.homeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        self.homeBtn.layer.cornerRadius = self.homeBtn.frame.size.height/2;
        self.homeBtn.layer.masksToBounds = YES;
    }
    return _homeBtn;
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
