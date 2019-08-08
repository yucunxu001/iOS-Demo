//
//  TimeViewController.m
//  PickerDemo
//
//  Created by mkrq-yh on 2019/8/7.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "TimeViewController.h"
#import "BRPickerView.h"

#define ScreenW ([UIScreen mainScreen].bounds.size.width)
#define ScreenH ([UIScreen mainScreen].bounds.size.height)

@interface TimeViewController ()

@end

@implementation TimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    /*
     --- 以下4种是系统自带的样式 ---
     BRDatePickerModeTime,              // HH:mm  15:30 UIDatePickerModeTime
     BRDatePickerModeDate,              // yyyy-MM-dd 2019-08-08 UIDatePickerModeDate
     BRDatePickerModeDateAndTime,       // yyyy-MM-dd HH:mm 2019-08-20 15:22 UIDatePickerModeDateAndTime
     BRDatePickerModeCountDownTimer,    // HH:mm 15:24 UIDatePickerModeCountDownTimer
     // --- 以下7种是自定义样式 ---
     BRDatePickerModeYMDHM,      // yyyy-MM-dd HH:mm 年月日时分
     BRDatePickerModeMDHM,       // MM-dd HH:mm 月日时分
     BRDatePickerModeYMD,        // yyyy-MM-dd 年月日
     BRDatePickerModeYM,         // yyyy-MM 年月
     BRDatePickerModeY,          // yyyy 年
     BRDatePickerModeMD,         // MM-dd 月日
     BRDatePickerModeHM          // HH:mm 时分
     */
    
    NSArray *array = @[
                       @"BRDatePickerModeTime",
                       @"BRDatePickerModeDate",
                       @"BRDatePickerModeDateAndTime",
                       @"BRDatePickerModeCountDownTimer",
                       @"BRDatePickerModeYMDHM",
                       @"BRDatePickerModeMDHM",
                       @"BRDatePickerModeYMD",
                       @"BRDatePickerModeYM",
                       @"BRDatePickerModeY",
                       @"BRDatePickerModeMD",
                       @"BRDatePickerModeHM",
                       @"取消选择的回调",
                       @"isAutoSelect",
                       ];
    
    for (int i = 0; i < array.count; i++) {
        UIButton *timeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        timeBtn.frame = CGRectMake(20, 100+40*i, ScreenW-40, 30);
        timeBtn.backgroundColor = [UIColor greenColor];
        timeBtn.tag = i;
        [timeBtn setTitle:array[i] forState:UIControlStateNormal];
        [timeBtn addTarget:self action:@selector(showTime:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:timeBtn];
    }
}

#pragma mark - 选择时间 -
- (void)showTime:(UIButton *)sender {
    NSLog(@"%ld",(long)sender.tag);
    
    /*
     --- 以下4种是系统自带的样式 ---
     BRDatePickerModeTime,              // HH:mm  15:30 UIDatePickerModeTime
     BRDatePickerModeDate,              // yyyy-MM-dd 2019-08-08 UIDatePickerModeDate
     BRDatePickerModeDateAndTime,       // yyyy-MM-dd HH:mm 2019-08-20 15:22 UIDatePickerModeDateAndTime
     BRDatePickerModeCountDownTimer,    // HH:mm 15:24 UIDatePickerModeCountDownTimer
     // --- 以下7种是自定义样式 ---
     BRDatePickerModeYMDHM,      // yyyy-MM-dd HH:mm 年月日时分
     BRDatePickerModeMDHM,       // MM-dd HH:mm 月日时分
     BRDatePickerModeYMD,        // yyyy-MM-dd 年月日
     BRDatePickerModeYM,         // yyyy-MM 年月
     BRDatePickerModeY,          // yyyy 年
     BRDatePickerModeMD,         // MM-dd 月日
     BRDatePickerModeHM          // HH:mm 时分
     */
    switch (sender.tag) {
        case 0:
        {
            [BRDatePickerView showDatePickerWithTitle:@"请选择时间-上/下午时分" dateType:BRDatePickerModeTime defaultSelValue:nil resultBlock:^(NSString *selectValue) {
                NSLog(@"时间==%@",selectValue);
                [sender setTitle:selectValue forState:UIControlStateNormal];
            }];
        }
            break;
        case 1:
        {
            [BRDatePickerView showDatePickerWithTitle:@"请选择时间-系统年月日" dateType:BRDatePickerModeDate defaultSelValue:nil resultBlock:^(NSString *selectValue) {
                NSLog(@"时间==%@",selectValue);
                [sender setTitle:selectValue forState:UIControlStateNormal];
            }];
        }
            break;
        case 2:
        {
            [BRDatePickerView showDatePickerWithTitle:@"请选择时间-系统时间" dateType:BRDatePickerModeDateAndTime defaultSelValue:nil resultBlock:^(NSString *selectValue) {
                NSLog(@"时间==%@",selectValue);
                [sender setTitle:selectValue forState:UIControlStateNormal];
            }];
        }
            break;
        case 3:
        {
            [BRDatePickerView showDatePickerWithTitle:@"请选择时间-系统时分" dateType:BRDatePickerModeCountDownTimer defaultSelValue:nil resultBlock:^(NSString *selectValue) {
                NSLog(@"时间==%@",selectValue);
                [sender setTitle:selectValue forState:UIControlStateNormal];
            }];
        }
            break;
        case 4:
        {
            NSDate *minDate = [NSDate br_setYear:1950 month:1 day:1 hour:0 minute:0];
            NSDate *maxDate = [NSDate br_setYear:2050 month:12 day:31 hour:0 minute:0];
            [BRDatePickerView showDatePickerWithTitle:@"请选择时间-系统年月日时分" dateType:BRDatePickerModeYMDHM defaultSelValue:nil minDate:minDate maxDate:maxDate isAutoSelect:NO themeColor:[UIColor greenColor] resultBlock:^(NSString *selectValue) {
                [sender setTitle:selectValue forState:UIControlStateNormal];
            }];
        }
            break;
        case 5:
        {
            NSDate *minDate = [NSDate br_setMonth:1 day:1 hour:0 minute:0];
            NSDate *maxDate = [NSDate br_setMonth:12 day:31 hour:12 minute:59];
            [BRDatePickerView showDatePickerWithTitle:@"请选择时间-年月日时分" dateType:BRDatePickerModeMDHM defaultSelValue:nil minDate:minDate maxDate:maxDate isAutoSelect:NO themeColor:[UIColor greenColor] resultBlock:^(NSString *selectValue) {
                [sender setTitle:selectValue forState:UIControlStateNormal];
            }];
        }
            break;
        case 6:
        {
            NSDate *minDate = [NSDate br_setYear:1950 month:1 day:1];
            NSDate *maxDate = [NSDate br_setYear:2050 month:12 day:31];
            [BRDatePickerView showDatePickerWithTitle:@"请选择时间-年月日" dateType:BRDatePickerModeYMD defaultSelValue:nil minDate:minDate maxDate:maxDate isAutoSelect:NO themeColor:[UIColor greenColor] resultBlock:^(NSString *selectValue) {
                [sender setTitle:selectValue forState:UIControlStateNormal];
            }];
        }
            break;
        case 7:
        {
            NSDate *minDate = [NSDate br_setYear:1950 month:1];
            NSDate *maxDate = [NSDate br_setYear:2050 month:12];
            [BRDatePickerView showDatePickerWithTitle:@"请选择时间-年月" dateType:BRDatePickerModeYM defaultSelValue:nil minDate:minDate maxDate:maxDate isAutoSelect:NO themeColor:[UIColor greenColor] resultBlock:^(NSString *selectValue) {
                [sender setTitle:selectValue forState:UIControlStateNormal];
            }];
        }
            break;
        case 8:
        {
            NSDate *minDate = [NSDate br_setYear:1950];
            NSDate *maxDate = [NSDate br_setYear:2050];
            [BRDatePickerView showDatePickerWithTitle:@"请选择时间-年" dateType:BRDatePickerModeY defaultSelValue:nil minDate:minDate maxDate:maxDate isAutoSelect:NO themeColor:[UIColor greenColor] resultBlock:^(NSString *selectValue) {
                [sender setTitle:selectValue forState:UIControlStateNormal];
            }];
        }
            break;
        case 9:
        {
            NSDate *minDate = [NSDate br_setMonth:1 day:1];
            NSDate *maxDate = [NSDate br_setMonth:12 day:31];
            [BRDatePickerView showDatePickerWithTitle:@"请选择时间-月日" dateType:BRDatePickerModeMD defaultSelValue:nil minDate:minDate maxDate:maxDate isAutoSelect:NO themeColor:[UIColor greenColor] resultBlock:^(NSString *selectValue) {
                [sender setTitle:selectValue forState:UIControlStateNormal];
            }];
        }
            break;
        case 10:
        {
            NSDate *minDate = [NSDate br_setHour:0 minute:0];
            NSDate *maxDate = [NSDate br_setHour:23 minute:59];
            [BRDatePickerView showDatePickerWithTitle:@"请选择时间-时分" dateType:BRDatePickerModeHM defaultSelValue:nil minDate:minDate maxDate:maxDate isAutoSelect:NO themeColor:[UIColor greenColor] resultBlock:^(NSString *selectValue) {
                [sender setTitle:selectValue forState:UIControlStateNormal];
            }];
        }
            break;
        case 11:
        {
            NSDate *minDate = [NSDate br_setYear:1950 month:1 day:1 hour:0 minute:0];
            NSDate *maxDate = [NSDate br_setYear:2050 month:12 day:31 hour:23 minute:59];
            [BRDatePickerView showDatePickerWithTitle:@"请选择时间—取消选择的回调" dateType:BRDatePickerModeYMDHM defaultSelValue:nil minDate:minDate maxDate:maxDate isAutoSelect:NO themeColor:[UIColor redColor] resultBlock:^(NSString *selectValue) {
                [sender setTitle:selectValue forState:UIControlStateNormal];
            } cancelBlock:^{
                NSLog(@"取消");
            }];
        }
            break;
        case 12:
        {
            NSDate *minDate = [NSDate br_setYear:1950 month:1 day:1 hour:0 minute:0];
            NSDate *maxDate = [NSDate br_setYear:2050 month:12 day:31 hour:23 minute:59];
            NSDate *date = [NSDate date];
            NSString *strDate = [NSDate br_getDateString:date format:@"yyyy-MM-dd HH:mm"];
            [BRDatePickerView showDatePickerWithTitle:@"请选择时间-设置选中" dateType:BRDatePickerModeYMDHM defaultSelValue:strDate minDate:minDate maxDate:maxDate isAutoSelect:NO themeColor:[UIColor redColor] resultBlock:^(NSString *selectValue) {
                [sender setTitle:selectValue forState:UIControlStateNormal];
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
