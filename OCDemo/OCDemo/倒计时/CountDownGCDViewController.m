//
//  CountDownGCDViewController.m
//  OCDemo
//
//  Created by mkrq-yh on 2019/3/22.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "CountDownGCDViewController.h"

@interface CountDownGCDViewController ()

@property (nonatomic,strong) UILabel *timeLabel;

@end

@implementation CountDownGCDViewController
{
    dispatch_source_t _timer;
}

- (void)viewWillDisappear:(BOOL)animated
{
    //关闭定时器
    if (_timer != nil) {
        dispatch_source_cancel(self->_timer);
        self->_timer = nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationItem.title = @"GCD倒计时";
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 300, self.view.frame.size.width-40, 50)];
    _timeLabel.backgroundColor = UIColor.redColor;
    [self.view addSubview:_timeLabel];
    
    [self CountDownGCD];
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

- (void)CountDownGCD {
    // 倒计时的时间 测试数据
    NSString *deadlineStr = @"2020-03-22 18:00:00";
    // 当前时间的时间戳
    NSString *nowStr = [self getCurrentTimeyyyymmdd];
    NSLog(@"nowStr==%@",nowStr);
    // 计算时间差值
    NSInteger secondsCountDown = [self getDateDifferenceWithNowDateStr:nowStr deadlineStr:deadlineStr];
    NSLog(@"secondsCountDown==%ld",secondsCountDown);
    __weak typeof(self) weakSelf = self;
    if (_timer == nil) {
        __block NSInteger timeout = secondsCountDown; // 倒计时时间
        if (timeout > 0) {
            //获取全局队列
            dispatch_queue_t global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            //创建一个定时器，并将定时器的任务交给全局队列执行(并行，不会造成主线程阻塞)
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, global);
            // 设置触发的间隔时间
            //1.0 * NSEC_PER_SEC  代表设置定时器触发的时间间隔为1s
            //0 * NSEC_PER_SEC    代表时间允许的误差是 0s
            dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
            dispatch_source_set_event_handler(_timer, ^{
                //1. 每调用一次 时间-1s
                timeout --;
                if(timeout <= 0){ //  当倒计时结束时做需要的操作: 关闭 活动到期不能提交
                    //关闭定时器
                    dispatch_source_cancel(self->_timer);
                    self->_timer = nil;
                    //注意: 在iOS中多线程处理时，UI控件的操作必须是交给主线程(主队列),在主线程中对timeLabel进行修改操作
                    dispatch_async(dispatch_get_main_queue(), ^{
                        weakSelf.timeLabel.text = @"当前活动已结束";
                    });
                } else {
                    // 倒计时重新计算 时/分/秒
                    NSInteger days = (int)(timeout/(3600*24));
                    NSInteger hours = (int)((timeout-days*24*3600)/3600);
                    NSInteger minute = (int)(timeout-days*24*3600-hours*3600)/60;
                    NSInteger second = timeout - days*24*3600 - hours*3600 - minute*60;
                    NSString *strTime = [NSString stringWithFormat:@"活动倒计时 %02ld : %02ld : %02ld", hours, minute, second];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (days == 0) {
                            weakSelf.timeLabel.text = strTime;
                        } else {
                            weakSelf.timeLabel.text = [NSString stringWithFormat:@"使用GCD来倒计时 %ld天 %02ld : %02ld : %02ld", days, hours, minute, second];
                        }
                    });
                }
            });
            dispatch_resume(_timer);
        }
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
