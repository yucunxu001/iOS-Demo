//
//  AddressViewController.m
//  PickerDemo
//
//  Created by mkrq-yh on 2019/8/7.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "AddressViewController.h"
#import "BRPickerView.h"

#define ScreenW ([UIScreen mainScreen].bounds.size.width)
#define ScreenH ([UIScreen mainScreen].bounds.size.height)

@interface AddressViewController ()

@property (nonatomic,strong) UIButton *addressBtn;

@end

@implementation AddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *array = @[
                       @"选择省市区",
                       @"选择省市区-有默认",
                       @"选择省市区-子定义颜色",
                       @"BRAddressPickerModeProvince 只显示省",
                       @"BRAddressPickerModeCity 显示省市",
                       @"BRAddressPickerModeArea显示省市区（默认",
                       @"自定义dataSource",
                       ];
    
    for (int i = 0; i < array.count; i++) {
        UIButton *addressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addressBtn.frame = CGRectMake(20, 100+40*i, ScreenW-40, 30);
        addressBtn.backgroundColor = [UIColor greenColor];
        addressBtn.tag = i;
        [addressBtn setTitle:array[i] forState:UIControlStateNormal];
        [addressBtn addTarget:self action:@selector(showAddress:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:addressBtn];
    }
}

#pragma mark - 选择地址 -
- (void)showAddress:(UIButton *)sender {
    NSLog(@"选择地址");
    switch (sender.tag) {
        case 0:
        {
            [BRAddressPickerView showAddressPickerWithDefaultSelected:nil resultBlock:^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
                NSString *address = [NSString stringWithFormat:@"%@ %@ %@", province.name, city.name, area.name];
                [sender setTitle:address forState:UIControlStateNormal];
            }];
        }
            break;
        case 1:
        {
            NSArray *defaultArray = @[@"浙江省", @"杭州市", @"西湖区"];
            [BRAddressPickerView showAddressPickerWithDefaultSelected:defaultArray resultBlock:^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
                NSString *address = [NSString stringWithFormat:@"%@ %@ %@", province.name, city.name, area.name];
                [sender setTitle:address forState:UIControlStateNormal];
            }];
        }
            break;
        case 2:
        {
            NSArray *defaultArray = @[@"浙江省", @"杭州市", @"西湖区"];
            [BRAddressPickerView showAddressPickerWithDefaultSelected:defaultArray isAutoSelect:NO themeColor:[UIColor greenColor] resultBlock:^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
                NSString *address = [NSString stringWithFormat:@"%@ %@ %@", province.name, city.name, area.name];
                [sender setTitle:address forState:UIControlStateNormal];
            }];
        }
            break;
        case 3:
        {
            //BRAddressPickerModeProvince = 1, 只显示省
            NSArray *defaultArray = @[@"浙江省", @"杭州市", @"西湖区"];
            [BRAddressPickerView showAddressPickerWithShowType:BRAddressPickerModeProvince defaultSelected:defaultArray isAutoSelect:YES themeColor:nil resultBlock:^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
                NSString *address = [NSString stringWithFormat:@"%@ %@ %@", province.name, city.name, area.name];
                [sender setTitle:address forState:UIControlStateNormal];
            } cancelBlock:^{
                NSLog(@"取消");
            }];
        }
            break;
        case 4:
        {
            //BRAddressPickerModeCity, 显示省市
            NSArray *defaultArray = @[@"浙江省", @"杭州市", @"西湖区"];
            [BRAddressPickerView showAddressPickerWithShowType:BRAddressPickerModeCity defaultSelected:defaultArray isAutoSelect:YES themeColor:nil resultBlock:^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
                NSString *address = [NSString stringWithFormat:@"%@ %@ %@", province.name, city.name, area.name];
                [sender setTitle:address forState:UIControlStateNormal];
            } cancelBlock:^{
                NSLog(@"取消");
            }];
        }
            break;
        case 5:
        {
            //BRAddressPickerModeArea显示省市区（默认
            NSArray *defaultArray = @[@"浙江省", @"杭州市", @"西湖区"];
            [BRAddressPickerView showAddressPickerWithShowType:BRAddressPickerModeArea defaultSelected:defaultArray isAutoSelect:YES themeColor:nil resultBlock:^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
                NSString *address = [NSString stringWithFormat:@"%@ %@ %@", province.name, city.name, area.name];
                [sender setTitle:address forState:UIControlStateNormal];
            } cancelBlock:^{
                NSLog(@"取消");
            }];
        }
            break;
        case 6:
        {
            NSArray *defaultArray = @[@"浙江省", @"杭州市", @"西湖区"];
            // dataSource 为空时，就默认使用框架内部提供的数据源（即 BRCity.plist）
            [BRAddressPickerView showAddressPickerWithShowType:BRAddressPickerModeArea dataSource:nil defaultSelected:defaultArray isAutoSelect:YES themeColor:nil resultBlock:^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
                NSString *address = [NSString stringWithFormat:@"%@ %@ %@", province.name, city.name, area.name];
                [sender setTitle:address forState:UIControlStateNormal];
            } cancelBlock:^{
                NSLog(@"取消");
            }];
        }
            break;
        default:
            break;
    }
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
