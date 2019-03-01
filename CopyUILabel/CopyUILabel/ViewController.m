//
//  ViewController.m
//  CopyUILabel
//
//  Created by mkrq-yh on 2019/3/1.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "ViewController.h"
#import "UILabel+Copy.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, self.view.frame.size.width-40, 50)];
    textField.backgroundColor = [UIColor grayColor];
    textField.textColor = [UIColor redColor];
    textField.clearsOnBeginEditing = YES;
    textField.placeholder = @"这是提示文字";
    textField.font = [UIFont boldSystemFontOfSize:25.0f];
    [self.view addSubview:textField];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 300, self.view.frame.size.width-40, 50)];
    label.copyable = YES;
    label.copyString = @"123456";
    label.text = @"复制复制复制复制复制复制";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:label];
    
}


@end
