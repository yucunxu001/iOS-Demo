//
//  FlexTableViewController.m
//  FlexLibDemo
//
//  Created by mkrq-yh on 2018/11/27.
//  Copyright © 2018 mkrq-yh. All rights reserved.
//

#import "FlexTableViewController.h"
#import "FlexTableViewCell.h"

@interface FlexTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation FlexTableViewController
{
    NSArray *dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dataArray = @[
                  @{
                      @"one": @"小灰",
                      @"title": @"大家好，我是小灰",
                      @"content": @"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈",
                      },
                  @{
                      @"one": @"小那",
                      @"title": @"大家好，我是小那",
                      @"content": @"哈哈哈哈哈哈哈哈哈哈卡萨丁给厚爱猴赛玻璃撒大哥就离开isad刚好里撒大哥卡萨丁你啥都刚好V领付款撒拉卡石膏板 哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈",
                      },
                  @{
                      @"one": @"小灰2",
                      @"title": @"大家好，我是小灰3",
                      @"content": @"哈哈哈哈哈哈哈哈哈哈哈哈哈哈多喝水都会和你是否添加上大号还是等会撒黄金时代会受到很大双方都好不撒大哥撒地方合适的话是的粉红色的国防部哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈",
                      },
                  @{
                      @"one": @"小灰4",
                      @"title": @"大家好，我是小灰4",
                      @"content": @"哈哈哈哈哈哈哈哈哈哈ad噶尔和天津科技可能就会噶大概好哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈",
                      },
                  @{
                      @"one": @"小灰5",
                      @"title": @"大家好，我是小灰5",
                      @"content": @"哈哈哈哈哈哈哈哈哈哈哈哈哈矮冬瓜撒大哥大撒旦飞洒和融通不让他哈市的个人水电费和根本安然恶化哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈",
                      },
                  @{
                      @"one": @"小灰6",
                      @"title": @"大家好，我是小灰6",
                      @"content": @"哈哈哈哈哈哈哈哈哈哈哈哈哈哈受到国家法规和内部阿巴瑟他人ad噶不若过是发的是哒哒哒哒哒哒多多多多后我爱好嘎啦果  康好看撒谎 阿克苏挂号费凯撒哈哈撒个哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈",
                      },
                  @{
                      @"one": @"小灰7",
                      @"title": @"大家好，我是小灰7",
                      @"content": @"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈收到公司的股份撒大大撒地方哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈",
                      },
                  @{
                      @"one": @"小灰8",
                      @"title": @"大家好，我是小灰8",
                      @"content": @"哈哈哈哈哈哈88888888888888哈哈哈哈哈哈哈哈哈哈是的噶水电费等会叫你卡萨U盾官方是卡萨甲BUI理发店GV卡接收到GV巴萨的恐惧哈哈哈哈哈哈哈哈哈哈哈哈哈哈",
                      },
                  ];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerClass:[FlexTableViewCell class] forCellReuseIdentifier:@"cellId"];
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FlexTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (cell==nil) {
        cell = [[FlexTableViewCell alloc] initWithFlex:nil reuseIdentifier:@"cellId"];
    }
    [cell setData:dataArray[indexPath.row]];
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 50;
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
