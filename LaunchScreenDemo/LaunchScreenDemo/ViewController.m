//
//  ViewController.m
//  LaunchScreenDemo
//
//  Created by mkrq-yh on 2019/10/29.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "ViewController.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@property (nonatomic,strong) UITextField *inputTextField;
@property (nonatomic,strong) UILabel *nameLb;
@property (nonatomic,strong) UIButton *delBtn;
@property (nonatomic,strong) UIView *customInputView;
@property (nonatomic, strong) UIToolbar *customAccessoryView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, kScreenWidth, 100)];
    label.text = @"黑暗模式";
    label.textColor = [UIColor greenColor];
    label.font = [UIFont systemFontOfSize:30];
    label.textAlignment = NSTextAlignmentCenter;
//    label.backgroundColor = [UIColor grayColor];
    [self.view addSubview:label];
    
//    [self createTextField];
    
}

- (void)createTextField {
      _nameLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
      _nameLb.text = @"密码：";
      _nameLb.textColor = [UIColor redColor];
      _nameLb.font = [UIFont systemFontOfSize:20];
      _nameLb.backgroundColor = [UIColor yellowColor];
    
      _delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
      _delBtn.frame = CGRectMake(0, 0, 100, 50);
      [_delBtn setTitle:@"删除" forState:UIControlStateNormal];
      [_delBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
      _delBtn.titleLabel.font = [UIFont systemFontOfSize:20];
      [_delBtn addTarget:self action:@selector(delBtnClick) forControlEvents:UIControlEventTouchUpInside];
      
      _inputTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, 50)];
      _inputTextField.borderStyle = UITextBorderStyleRoundedRect;
      _inputTextField.placeholder = @"请输入密码";
      _inputTextField.text = @"123456";
      _inputTextField.font = [UIFont systemFontOfSize:20];
      _inputTextField.textColor = [UIColor greenColor];
      _inputTextField.backgroundColor = [UIColor grayColor];
      _inputTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
      _inputTextField.leftView = _nameLb;
      _inputTextField.leftViewMode = UITextFieldViewModeAlways;
      _inputTextField.rightView = _delBtn;
      _inputTextField.rightViewMode = UITextFieldViewModeAlways;
      [self.view addSubview:_inputTextField];
      
      /*自定义键盘 键盘高度可以自定义，按需求来*/
      _customInputView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 261)];
      _customInputView.backgroundColor = [UIColor lightGrayColor];
      UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, kScreenWidth, 40)];
      label.textAlignment = NSTextAlignmentCenter;
      label.text = @"自定义inputView";
      [_customInputView addSubview:label];
      _inputTextField.inputView = _customInputView;
      
      /*该view会作为辅助视图出现在键盘上面，和键盘一块弹出，无论inputView多高*/
      _customAccessoryView = [[UIToolbar alloc]initWithFrame:CGRectMake(0,0,kScreenWidth,40)];
      _customAccessoryView.barTintColor = [UIColor orangeColor];
      UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
      UIBarButtonItem *finish = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
      [_customAccessoryView setItems:@[space,space,finish]];
      _inputTextField.inputAccessoryView = _customAccessoryView;
}

- (void)done{
    [_inputTextField resignFirstResponder];
}

-(void)delBtnClick {
    _inputTextField.text = @"";
}


@end
