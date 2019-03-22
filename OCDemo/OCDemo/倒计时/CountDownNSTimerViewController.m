//
//  CountDownNSTimerViewController.m
//  OCDemo
//
//  Created by mkrq-yh on 2019/3/22.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "CountDownNSTimerViewController.h"

@interface CountDownNSTimerViewController ()

@property (nonatomic,strong) NSTimer *activeTimer;
@property (nonatomic,strong) UILabel *timeLabel;

@end

@implementation CountDownNSTimerViewController
{
    NSInteger secondsCountDown;
}

- (void)viewWillDisappear:(BOOL)animated {
    if (_activeTimer != nil) {
        [_activeTimer invalidate];
        _activeTimer = nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationItem.title = @"NSTimer倒计时";
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 300, self.view.frame.size.width-40, 50)];
    _timeLabel.backgroundColor = UIColor.redColor;
    [self.view addSubview:_timeLabel];
    
    [self countDown];
}

/**
 *  获取当天的字符串
 *
 *  @return 格式为年-月-日 时分秒
 */
- (NSString *)getCurrentTimeyyyymmdd {
    
    NSDate *now = [NSDate date];
    NSDateFormatter *formatDay = [[NSDateFormatter alloc] init];
    formatDay.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *dayStr = [formatDay stringFromDate:now];
    
    return dayStr;
}
/**
 *  获取时间差值  截止时间-当前时间
 *  nowDateStr : 当前时间
 *  deadlineStr : 截止时间
 *  @return 时间戳差值
 */
- (NSInteger)getDateDifferenceWithNowDateStr:(NSString*)nowDateStr deadlineStr:(NSString*)deadlineStr {
    
    NSInteger timeDifference = 0;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yy-MM-dd HH:mm:ss"];
    NSDate *nowDate = [formatter dateFromString:nowDateStr];
    NSDate *deadline = [formatter dateFromString:deadlineStr];
    NSTimeInterval oldTime = [nowDate timeIntervalSince1970];
    NSTimeInterval newTime = [deadline timeIntervalSince1970];
    timeDifference = newTime - oldTime;
    
    return timeDifference;
}
- (void)countDown {
    // 倒计时的时间 测试数据
    NSString *deadlineStr = @"2020-03-22 18:00:00";
    // 当前时间的时间戳
    NSString *nowStr = [self getCurrentTimeyyyymmdd];
    
    secondsCountDown = [self getDateDifferenceWithNowDateStr:nowStr deadlineStr:deadlineStr];

    // 启动倒计时后会每秒钟调用一次方法
    _activeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(activeCountDownAction) userInfo:nil repeats:YES];
    [_activeTimer fire];
    
}

- (void)activeCountDownAction {
    // 重新计算 时/分/秒
    secondsCountDown--;//减一秒
    NSString *hour = [NSString stringWithFormat:@"%02ld", secondsCountDown / 3600];
    NSString *minute = [NSString stringWithFormat:@"%02ld", (secondsCountDown % 3600) / 60];
    NSString *second = [NSString stringWithFormat:@"%02ld", secondsCountDown % 60];
    NSString *countDownTime = [NSString stringWithFormat:@"%@ : %@ : %@", hour, minute, second];
    NSLog(@"countDownTime==%@",countDownTime);
    // 修改倒计时标签及显示内容
    self.timeLabel.text = [NSString stringWithFormat:@"NSTimer 活动倒计时: %@", countDownTime];
    // 当倒计时结束时做需要的操作: 比如活动到期不能提交
    if(secondsCountDown <= 0) {
        self.timeLabel.text = @"当前活动已结束";
        [_activeTimer invalidate];
        _activeTimer = nil;
        return;
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
