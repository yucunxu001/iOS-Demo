//
//  ViewController.m
//  CircleProgress
//
//  Created by mkrq-yh on 2019/3/25.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "ViewController.h"

#import "CircleProgress.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CircleProgress *progress  = [[CircleProgress alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    progress.lineWidth = 5;
    progress.duration = 1;
    progress.mainColor = UIColor.redColor;
    progress.fillColor = UIColor.grayColor;
    progress.progress = 0.9;
    [self.view addSubview:progress];
    
}


@end
