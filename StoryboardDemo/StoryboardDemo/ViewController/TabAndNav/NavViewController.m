//
//  NavViewController.m
//  StoryboardDemo
//
//  Created by mkrq-yh on 2019/4/18.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "NavViewController.h"

@interface NavViewController ()<UIGestureRecognizerDelegate>

@end

@implementation NavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    //设置NavBar背景颜色和字体颜色
//    self.navigationBar.barTintColor = kNavColor;
//    NSDictionary *dict = @{NSForegroundColorAttributeName : kColor333,NSFontAttributeName:kFont(32)};
//    [self.navigationBar setTitleTextAttributes:dict];
//    self.view.backgroundColor = kBgColor;
    
    // 如果滑动移除控制器的功能失效，清空代理（让导航控制器重新设置这个功能）
    self.interactivePopGestureRecognizer.delegate = nil;
    
}

#pragma mark -- 重写push方法 添加返回按钮 --
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    // 左上角的返回键
    // 注意：第一个控制器不需要返回键
    // if不是第一个push进来的子控制器{
    if (self.childViewControllers.count >= 1) {
        // 左上角的返回按钮
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        backButton.mj_size = CGSizeMake(Size(80), 44);
        
        CGRect frame = backButton.frame;
        frame.size = CGSizeMake(60, 44);
        backButton.frame = frame;
        
        [backButton setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateHighlighted];
        
//        //判断是否FAQViewController webView
//        if ([viewController isKindOfClass:[FAQViewController class]]) {
//            backButton.tag = 1001;
//        }
        
        // 让按钮内部的所有内容左对齐
        backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        //        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0); // 这里微调返回键的位置可以让它看上去和左边紧贴
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        viewController.hidesBottomBarWhenPushed = YES; // 隐藏底部的工具条
        
    }
    [super pushViewController:viewController animated:animated];
}

#pragma mark -- 返回按钮 --
- (void)back:(UIButton *)sender
{
//    if (sender.tag == 1001) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"FAQViewControllerBackBtn" object:nil];
//    } else {
//        [self popViewControllerAnimated:YES];// 这里不用写self.navigationController，因为它自己就是导航控制器
//    }
    [self popViewControllerAnimated:YES];// 这里不用写self.navigationController，因为它自己就是导航控制器
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
