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
    
//    [self useMasonry];
    [self useCalculator];

}

- (void)useMasonry {
 
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view1];
    
//    //居中 大小100
//    [view1 makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.view);
//        make.size.equalTo(CGSizeMake(px(400), px(400)));
//    }];
    
//    //边距10
//    [view1 makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(px(10), px(10), TabHeight + px(10), px(10)));
//    }];
    
    //view1 和 view2 高度为150 垂直居中 且等宽且等间隔排列 间隔为10
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor redColor];
    [self.view addSubview:view2];
    
    [view1 makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(view2);
        make.height.equalTo(px(150));
        make.left.equalTo(self.view).offset(px(10));
        make.right.equalTo(view2.left).offset(px(-10));
        make.centerY.equalTo(self.view.centerY);
    }];

    [view2 makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(view1);
        make.height.equalTo(px(150));
        make.right.equalTo(self.view).offset(px(-10));
        make.centerY.equalTo(self.view.centerY);
    }];
    
}

#pragma mark - 计算器
- (void)useCalculator {
    //申明区域，displayView是显示区域，keyboardView是键盘区域
    UIView *displayView = [UIView new];
    [displayView setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:displayView];
    
    UIView *keyboardView = [UIView new];
    keyboardView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:keyboardView];
    
    [displayView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.equalTo(keyboardView).multipliedBy(0.3f);
    }];

    [keyboardView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(displayView.bottom);
        make.bottom.equalTo(self.view).offset(-TabHeight);
    }];
    [keyboardView layoutIfNeeded];

    //显示结果
    UILabel *displayNum = [[UILabel alloc]init];
    [displayView addSubview:displayNum];
    displayNum.backgroundColor = [UIColor yellowColor];
    displayNum.text = @"0";
    displayNum.font = [UIFont fontWithName:@"HeiTi SC" size:70];
    displayNum.textColor = [UIColor whiteColor];
    displayNum.textAlignment = NSTextAlignmentRight;
    [displayNum makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(displayView).offset(px(-10));
        make.bottom.equalTo(displayView).offset(-10);
    }];
    
    //定义键盘键名称，？号代表合并的单元格
    NSArray *keys = @[@"AC",@"+/-",@"%",@"÷"
                      ,@"7",@"8",@"9",@"x"
                      ,@"4",@"5",@"6",@"-"
                      ,@"1",@"2",@"3",@"+"
                      ,@"0",@"?",@".",@"="];
    for (int i=0; i < keys.count; i++) {
        int row = i/4;
        int col = i%4;
        //键样式
        UIButton *keyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [keyboardView addSubview:keyBtn];
        [keyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [keyBtn setTitle:keys[i] forState:UIControlStateNormal];
        [keyBtn.layer setBorderWidth:1];
        [keyBtn.layer setBorderColor:[[UIColor blackColor]CGColor]];
        [keyBtn.titleLabel setFont:[UIFont fontWithName:@"Arial-BoldItalicMT" size:30]];
        keyBtn.tag = i;
        [keyBtn addTarget:self action:@selector(keyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat width = keyboardView.frame.size.width/4;
        CGFloat height = keyboardView.frame.size.height/5;

        if ([keys[i] isEqualToString:@"?"]) {//移除？按钮
            [keyBtn removeFromSuperview];
        }else {
            [keyBtn makeConstraints:^(MASConstraintMaker *make) {
                if ([keys[i] isEqualToString:@"0"]) {
                    make.width.equalTo(keyboardView).multipliedBy(0.5f);
                    make.height.equalTo(keyboardView).multipliedBy(0.2f);
                } else {
                    make.width.equalTo(keyboardView).multipliedBy(0.25f);
                    make.height.equalTo(keyboardView).multipliedBy(0.2f);
                }
                CGFloat x = width*col;
                CGFloat y = height*row;
                make.left.equalTo(keyboardView).offset(x);
                make.top.equalTo(keyboardView).offset(y);
            }];
        }
    }
    
    /*
    //定义键盘键名称，？号代表合并的单元格
    NSArray *keys = @[@"AC",@"+/-",@"%",@"÷"
                      ,@"7",@"8",@"9",@"x"
                      ,@"4",@"5",@"6",@"-"
                      ,@"1",@"2",@"3",@"+"
                      ,@"0",@"?",@".",@"="];
    int indexOfKeys = 0;
    for (NSString *key in keys){
        //循环所有键
        indexOfKeys++;
        int rowNum = indexOfKeys %4 ==0? indexOfKeys/4:indexOfKeys/4 +1;
        int colNum = indexOfKeys %4 ==0? 4 :indexOfKeys %4;
        NSLog(@"index is:%d and row:%d,col:%d",indexOfKeys,rowNum,colNum);
        //键样式
        UIButton *keyView = [UIButton buttonWithType:UIButtonTypeCustom];
        [keyboardView addSubview:keyView];
        [keyView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [keyView setTitle:key forState:UIControlStateNormal];
        [keyView.layer setBorderWidth:1];
        [keyView.layer setBorderColor:[[UIColor blackColor]CGColor]];
        [keyView.titleLabel setFont:[UIFont fontWithName:@"Arial-BoldItalicMT" size:30]];
        //键约束
        [keyView mas_makeConstraints:^(MASConstraintMaker *make) {
            //处理 0 合并单元格
            if([key isEqualToString:@"0"] || [key isEqualToString:@"?"] ){
                if([key isEqualToString:@"0"]){
                    [keyView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.height.equalTo(keyboardView.mas_height).with.multipliedBy(.2f);
                        make.width.equalTo(keyboardView.mas_width).multipliedBy(.5);
                        make.left.equalTo(keyboardView.mas_left);
                        make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(.9f);
                    }];
                }if([key isEqualToString:@"?"]){
                    [keyView removeFromSuperview];
                }
            }
            //正常的单元格
            else{
                make.width.equalTo(keyboardView.mas_width).with.multipliedBy(.25f);
                make.height.equalTo(keyboardView.mas_height).with.multipliedBy(.2f);
                //按照行和列添加约束，这里添加行约束
                switch (rowNum) {
                    case 1:
                    {
                        make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(.1f);
                        keyView.backgroundColor = [UIColor colorWithRed:205 green:205 blue:205 alpha:1];
                    }
                        break;
                    case 2:
                    {
                        make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(.3f);
                    }
                        break;
                    case 3:
                    {
                        make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(.5f);
                    }
                        break;
                    case 4:
                    {
                        make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(.7f);
                    }
                        break;
                    case 5:
                    {
                        make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(.9f);
                    }
                        break;
                    default:
                        break;
                }
                //按照行和列添加约束，这里添加列约束
                switch (colNum) {
                    case 1:
                    {
                        make.left.equalTo(keyboardView.mas_left);
                    }
                        break;
                    case 2:
                    {
                        make.right.equalTo(keyboardView.mas_centerX);
                    }
                        break;
                    case 3:
                    {
                        make.left.equalTo(keyboardView.mas_centerX);
                    }
                        break;
                    case 4:
                    {
                        make.right.equalTo(keyboardView.mas_right);
                        [keyView setBackgroundColor:[UIColor colorWithRed:243 green:127 blue:38 alpha:1]];
                    }
                        break;
                    default:
                        break;
                }
            }
        }];
    }
    */

}

- (void)keyBtnClick:(UIButton *)sender {
    NSLog(@"%@",sender.titleLabel.text);
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
