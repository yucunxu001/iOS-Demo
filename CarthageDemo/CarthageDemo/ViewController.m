//
//  ViewController.m
//  CarthageDemo
//
//  Created by mkrq-yh on 2019/4/22.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking/AFNetworking.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSDictionary *dict = @{@"page":@"1"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //添加请求头
    [manager.requestSerializer setValue:@"101" forHTTPHeaderField:@"userId"];
    [manager.requestSerializer setValue:@"81158b2MEI1T0Z1UkQvcXNHNHdwNCs1Z0tTZz09" forHTTPHeaderField:@"userKey"];
    [manager.requestSerializer setValue:@"1.1.6" forHTTPHeaderField:@"versionCode"];
    [manager.requestSerializer setValue:@"986647E4-5DF1-4283-82BC-E3C6FB5EFBEC" forHTTPHeaderField:@"imei"];
    [manager.requestSerializer setValue:@"23E45DCC-AE65-46C2-B36A-ADBC19AB054C" forHTTPHeaderField:@"serialId"];
    [manager.requestSerializer setValue:@"0" forHTTPHeaderField:@"pushId"];
    [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"client"];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30;//请求超时的时间
    [manager POST:@"http://www.7zhaitu8.cn/index/indexProd" parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *responseObj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"responseObj==%@",responseObj);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error==%@",error);
    }];
    

}


@end
