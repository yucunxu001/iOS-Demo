//
//  ViewController.m
//  SVProgressHUDUseDemo
//
//  Created by mkrq-yh on 2019/5/8.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "ViewController.h"
#import "SVProgressHUD.h"

@interface ViewController ()

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIView *demoView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *array = @[
                       @"show",
                       @"showWithStatus",
                       @"showSuccessWithStatus",
                       @"showErrorWithStatus",
                       @"showInfoWithStatus",
                       @"showProgress",
                       ];
    int index = 0;
    for (NSString *title in array) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(20, 50+index*60, self.view.frame.size.width-40, 50);
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        btn.tag = index;
        btn.backgroundColor = [UIColor grayColor];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:btn];
        index++;
    }
    
//    self.demoView = [[UIView alloc] initWithFrame:CGRectMake(10, 500, 200, 200)];
//    self.demoView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:self.demoView];
    
    /*
        通知，SVProgressHUD会使用到四个通知
        SVProgressHUDWillAppearNotification
        SVProgressHUDDidAppearNotification
        SVProgressHUDWillDisappearNotification
        SVProgressHUDDidDisappearNotification
        每一通知会传递一个userinfo字典传递HUD的提示信息，key为``SVProgressHUDStatusUserInfoKey``。
        当用户触摸提示的整个屏幕的时候会发出``SVProgressHUDDidReceiveTouchEventNotification``通知，
        当用户直接触摸HUD的时候会发出``SVProgressHUDDidTouchDownInsideNotification``通知。
     */
    
}

- (void)btnClick:(UIButton *)sender {
    /*
     设置HUD背景颜色和文本颜色
     SVProgressHUDStyleLight： 默认图层样式 HUD白色背景 黑色文本 ，HUD背景模糊
     SVProgressHUDStyleDark：  HUD黑色背景 白色文本 ，HUD背景模糊
     SVProgressHUDStyleCustom：自定义HUD背景和文本颜色
     */
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    //设置HUD和文本的颜色
    [SVProgressHUD setForegroundColor:[UIColor yellowColor]];
    //设置HUD背景颜色
    [SVProgressHUD setBackgroundColor:[UIColor purpleColor]];
    
    /*
     设置HUD背景图层的样式
     SVProgressHUDMaskTypeNone：默认图层样式，当HUD显示的时候，允许用户交互。
     SVProgressHUDMaskTypeClear：当HUD显示的时候，不允许用户交互。
     SVProgressHUDMaskTypeBlack：当HUD显示的时候，不允许用户交互，且显示黑色背景图层。
     SVProgressHUDMaskTypeGradient：当HUD显示的时候，不允许用户交互，且显示渐变的背景图层。
     SVProgressHUDMaskTypeCustom：当HUD显示的时候，不允许用户交互，且显示背景图层自定义的颜色。
     */
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
//    [SVProgressHUD setBackgroundLayerColor:[UIColor redColor]];
    
    /*
     定义HUD动画样式
     SVProgressHUDAnimationTypeFlat,     // 默认动画类型，和Android类似 圆圈y旋转
     SVProgressHUDAnimationTypeNative    // iOS自带的旋转菊花
     */
    //动画效果
    [SVProgressHUD setDefaultAnimationType:(SVProgressHUDAnimationTypeNative)];
    
//    [SVProgressHUD setContainerView:self.demoView];
    /*设置HUD样式*/
    [SVProgressHUD setFont:[UIFont systemFontOfSize:16]];
    [SVProgressHUD setBorderColor:[UIColor blueColor]];
    [SVProgressHUD setBorderWidth:1];
    [SVProgressHUD setCornerRadius:10];
    
    
    switch (sender.tag) {
        case 0:
        {
            [SVProgressHUD show];
        }
            break;
        case 1:
        {
            [SVProgressHUD showWithStatus:@"正在登录"];
        }
            break;
        case 2:
        {
            [SVProgressHUD showSuccessWithStatus:@"登录成功"];
        }
            break;
        case 3:
        {
            [SVProgressHUD showErrorWithStatus:@"登录失败"];
        }
            break;
        case 4:
        {
            [SVProgressHUD showInfoWithStatus:@"密码错误"];
        }
            break;
        case 5:
        {
            [SVProgressHUD showProgress:0.3];
        }
            break;
            
        default:
            break;
    }
    
    if ([SVProgressHUD isVisible]) {
        
    }
    [NSTimer scheduledTimerWithTimeInterval:2 repeats:NO block:^(NSTimer * _Nonnull timer) {
        NSLog(@"取消show");
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 处理耗时的操作
            dispatch_async(dispatch_get_main_queue(), ^{
//                [SVProgressHUD dismiss];
                [SVProgressHUD dismissWithDelay:5];
            });
        });
    }];

}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width)];
        [self.view addSubview:self.scrollView];
    }
    return _scrollView;
}


@end
