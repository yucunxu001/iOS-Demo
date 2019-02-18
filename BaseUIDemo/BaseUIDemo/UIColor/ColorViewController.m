//
//  ColorViewController.m
//  BaseUIDemo
//
//  Created by mkrq-yh on 2019/1/9.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "ColorViewController.h"

@interface ColorViewController ()

@end

@implementation ColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    self.view.backgroundColor = kColor(@"#ffff00");

    UIView *colorView = [[UIView alloc] initWithFrame:CGRectMake(10, 100, 100, 50)];
    colorView.backgroundColor = [UIColor colorFromHexString:@"#ff0000"];
    [self.view addSubview:colorView];
    
    UIView *colorView2 = [[UIView alloc] initWithFrame:CGRectMake(120, 100, 100, 50)];
    colorView2.backgroundColor = [UIColor greenColor];
    [self.view addSubview:colorView2];
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
