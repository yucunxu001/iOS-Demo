//
//  FindViewController.m
//  StoryboardDemo
//
//  Created by mkrq-yh on 2019/4/18.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "FindViewController.h"

@interface FindViewController ()
@property (weak, nonatomic) IBOutlet UIView *findView;

@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"%f",self.findView.frame.origin.x);
    NSLog(@"%f",self.findView.frame.origin.y);
    NSLog(@"%f",self.findView.frame.size.width);
    NSLog(@"%f",self.findView.frame.size.height);

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
