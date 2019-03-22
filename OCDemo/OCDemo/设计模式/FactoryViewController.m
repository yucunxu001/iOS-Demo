//
//  FactoryViewController.m
//  OCDemo
//
//  Created by mkrq-yh on 2019/3/21.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "FactoryViewController.h"
#import "AnimalFactory.h"

@interface FactoryViewController ()

@end

@implementation FactoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"工厂模式";
    
    AnimalFactory *animal = [[AnimalFactory alloc] init];
    [animal createObject:DogClassName complete:^(Animal * _Nonnull obj) {
        [obj printClassName];
    }];
    [animal createObject:CatClassName complete:^(Animal * _Nonnull obj) {
        [obj printClassName];
    }];
    
    
    
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
