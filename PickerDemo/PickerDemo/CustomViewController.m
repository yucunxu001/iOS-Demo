//
//  CustomViewController.m
//  PickerDemo
//
//  Created by mkrq-yh on 2019/8/7.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "CustomViewController.h"
#import "BRPickerView.h"

#define ScreenW ([UIScreen mainScreen].bounds.size.width)
#define ScreenH ([UIScreen mainScreen].bounds.size.height)

@interface CustomViewController ()

@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *array = @[
                       @"选择学历",
                       @"选择月份",
                       @"选择学历-取消有回调",
                       @"多行多列",
                       ];
    
    for (int i = 0; i < array.count; i++) {
        UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        customBtn.frame = CGRectMake(20, 100+40*i, ScreenW-40, 30);
        customBtn.backgroundColor = [UIColor greenColor];
        customBtn.tag = i;
        [customBtn setTitle:array[i] forState:UIControlStateNormal];
        [customBtn addTarget:self action:@selector(showCustom:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:customBtn];
    }
}

#pragma mark - 自定义选择 -
- (void)showCustom:(UIButton *)sender {
    switch (sender.tag) {
        case 0:
        {
            NSArray *dataSource = @[@"幼儿园",@"小学",@"初中",@"高中", @"大专", @"本科", @"硕士", @"博士", @"博士后",@"超神"];
            NSString *defaultValue = @"本科";
            [BRStringPickerView showStringPickerWithTitle:@"选择学历" dataSource:dataSource defaultSelValue:defaultValue resultBlock:^(id selectValue) {
                NSLog(@"%@",selectValue);
                [sender setTitle:selectValue forState:UIControlStateNormal];
            }];
        }
            break;
        case 1:
        {
            NSArray *dataSource = @[@"1月",@"2月",@"3月",@"4月",@"5月",@"6月",@"7月",@"8月",@"9月",@"10月",@"11月",@"12月"];
            NSString *defaultValue = @"8月";
            [BRStringPickerView showStringPickerWithTitle:@"选择月份" dataSource:dataSource defaultSelValue:defaultValue isAutoSelect:YES themeColor:nil resultBlock:^(id selectValue) {
                NSLog(@"%@",selectValue);
                [sender setTitle:selectValue forState:UIControlStateNormal];
            }];
        }
            break;
        case 2:
        {
            NSArray *dataSource = @[@"幼儿园",@"小学",@"初中",@"高中", @"大专", @"本科", @"硕士", @"博士", @"博士后",@"超神"];
            NSString *defaultValue = @"本科";
            [BRStringPickerView showStringPickerWithTitle:@"选择学历" dataSource:dataSource defaultSelValue:defaultValue isAutoSelect:NO themeColor:[UIColor redColor] resultBlock:^(id selectValue) {
                NSLog(@"%@",selectValue);
                [sender setTitle:selectValue forState:UIControlStateNormal];
            } cancelBlock:^{
                NSLog(@"取消");
            }];
        }
            break;
        case 3:
        {
            NSArray *dataSource = @[
                                    @[@"111",@"222",@"333",@"444",@"555",@"666",@"777",@"888",@"999",@"000"],
                                    @[@"aaa",@"bbb",@"ccc",@"ddd",@"eee",@"fff",@"ggg",@"hhh",@"iii",@"jjj"],
                                    @[@"AAA",@"BBB",@"CCC",@"DDD",@"EEE",@"FFF",@"GGG",@"HHH",@"III",@"JJJ"],
                                    ];
            NSArray *defaultValue = @[@"333",@"ccc",@"CCC"];
            [BRStringPickerView showStringPickerWithTitle:@"自定义多行多列" dataSource:dataSource defaultSelValue:defaultValue isAutoSelect:NO themeColor:[UIColor redColor] resultBlock:^(id selectValue) {
                NSLog(@"%@",selectValue);
                NSString *string = [NSString stringWithFormat:@"%@ %@ %@",selectValue[0],selectValue[1],selectValue[2]];
                [sender setTitle:string forState:UIControlStateNormal];
            } cancelBlock:^{
                NSLog(@"取消");
            }];
        }
            break;
        default:
            break;
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
