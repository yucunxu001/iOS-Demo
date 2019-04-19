//
//  HomeViewController.m
//  StoryboardDemo
//
//  Created by mkrq-yh on 2019/4/18.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h"

static NSString * const kUserID = @"123";

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;



@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"kUserID==%@",kUserID);
    
    NSLog(@"kScreenWidth==%f",kScreenWidth);
    NSLog(@"kScreenHeight==%f",kScreenHeight);

    NSLog(@"StartBarHeight==%f",StartBarHeight);
    NSLog(@"NavHeight==%f",NavHeight);
    NSLog(@"BarHeight==%f",BarHeight);
    NSLog(@"TabHeight==%f",TabHeight);

    NSLog(@"redColor==%@",[UIColor redColor]);
    NSLog(@"redColor==%@",kColor(0xff0000));

    NSLog(@"kDeviceName==%@",kDeviceName);
    NSLog(@"kSystemVersion==%@",kSystemVersion);
    NSLog(@"kPhoneModel==%@",kPhoneModel);
    NSLog(@"kAppName==%@",kAppName);
    NSLog(@"kAppVersion==%@",kAppVersion);
    NSLog(@"kAppVersionInt==%@",kAppVersionInt);
    

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (cell == nil) {
        cell = [[HomeTableViewCell alloc] init];
    }
    return cell;
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
