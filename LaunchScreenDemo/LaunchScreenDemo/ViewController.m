//
//  ViewController.m
//  LaunchScreenDemo
//
//  Created by mkrq-yh on 2019/10/29.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *msgImg;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.msgImg.backgroundColor = [UIColor redColor];
    self.msgImg.tintColor = [UIColor yellowColor];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    label.text = @"测试label";
    label.textColor = [UIColor greenColor];
    label.font = [UIFont systemFontOfSize:30];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor grayColor];
    [self.view addSubview:label];
    
}


@end
