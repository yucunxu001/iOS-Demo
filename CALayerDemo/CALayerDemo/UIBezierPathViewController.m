//
//  UIBezierPathViewController.m
//  CALayerDemo
//
//  Created by mkrq-yh on 2019/5/10.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "UIBezierPathViewController.h"
#import "BezierView.h"

@interface UIBezierPathViewController ()

@end

@implementation UIBezierPathViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    BezierView *demoView= [[BezierView alloc] initWithFrame:self.view.bounds];
    demoView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:demoView];
    
}


- (void)drawLine {
    
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
