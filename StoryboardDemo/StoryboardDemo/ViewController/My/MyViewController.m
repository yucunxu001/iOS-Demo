//
//  MyViewController.m
//  StoryboardDemo
//
//  Created by mkrq-yh on 2019/4/18.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(px(10), px(100), kScreenWidth-px(20), px(100))];
//    view.backgroundColor = [UIColor greenColor];
//    [self.view addSubview:view];
//
//    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, px(300), px(745), px(100))];
//    view2.backgroundColor = [UIColor greenColor];
//    [self.view addSubview:view2];
    
    [self useMasonry];

}

- (void)useMasonry {
 
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view1];
    
    //居中 大小100
//    [view1 makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.view);
//        make.size.equalTo(CGSizeMake(px(100), px(100)));
//        make.width.equalTo(px(100));
//        make.height.equalTo(px(100));
//    }];
    
    //边距10
//    [view1 makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(100, 100, 100, 100));
//    }];
    
    //view1 和 view2 高度为150 垂直居中 且等宽且等间隔排列 间隔为10
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor redColor];
    [self.view addSubview:view2];
    
//    [view1 makeConstraints:^(MASConstraintMaker *make) {
//        make.width.equalTo(px(200));
//        make.height.equalTo(px(200));
//        make.top.equalTo(self.view).offset(px(100));
//        make.left.equalTo(self.view).offset(px(100));
//    }];
    
    [view1 makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(view2);
        make.height.equalTo(px(150));
        make.centerY.equalTo(self.view);
        make.left.equalTo(self.view).offset(px(10));
        make.right.equalTo(view2.left).offset(px(-10));
    }];

    [view2 makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(view1);
        make.height.equalTo(px(150));
        make.centerY.equalTo(view1);
        make.left.equalTo(view1.right).offset(px(10));
        make.right.equalTo(self.view).offset(px(-10));
    }];

    
    

}


- (void)useToast{
    
    [self.view makeToast:@"这是一个toast"];
//    [self.view makeToast:@"这是一个toast" duration:3.0 position:[NSValue valueWithCGPoint:CGPointMake(110, 110)]];
//    [self.view makeToast:@"这是一个toast" duration:3.0 position:CSToastPositionTop];
//    [self.view makeToast:@"这是一个toast" duration:3.0 position:CSToastPositionBottom];
//    [self.view makeToast:@"这是一个toast" duration:3.0 position:CSToastPositionCenter];

//    CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
//    style.backgroundColor = [UIColor greenColor];
//    style.titleColor = [UIColor redColor];
//    style.messageColor = [UIColor redColor];
    
//    [self.view makeToast:@"这是一个toast" duration:3.0 position:CSToastPositionCenter style:style];

//    [self.view makeToast:@"这是一个toast" duration:3.0 position:CSToastPositionCenter title:@"标题" image:[UIImage imageNamed:@"home_invite_login"] style:style completion:^(BOOL didTap) {
//        NSLog(@"hhhhhhhh");
//    }];
    
//    [self.view makeToastActivity:CSToastPositionCenter];
//    [self.view hideToastActivity];
    
    
//    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, px(745), px(100))];
//    view2.backgroundColor = [UIColor greenColor];
////    [self.view addSubview:view2];
//    [self.view showToast:view2];

    
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
