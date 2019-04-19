//
//  ViewController.m
//  LunBoDemo
//
//  Created by mkrq-yh on 2019/4/15.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "ViewController.h"
#import "HVWBorderShownCardsView.h"
#import "CardView/CardView.h"
#import "DemoView/DemoView.h"

@interface ViewController ()


@end

@implementation ViewController
{
    NSArray *realArray;
    NSMutableArray *dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    realArray = @[
                  @{@"img":@"image5",@"title":@"00000000"},
                  @{@"img":@"image1",@"title":@"11111111"},
                  @{@"img":@"image2",@"title":@"222222222"},
                  @{@"img":@"image3",@"title":@"333333333"},
                  @{@"img":@"image4",@"title":@"444444444"},
                  @{@"img":@"image5",@"title":@"555555555"},
                  @{@"img":@"image1",@"title":@"666666666"},
                  @{@"img":@"image2",@"title":@"777777777"},
                  @{@"img":@"image3",@"title":@"888888888"},
                  @{@"img":@"image4",@"title":@"999999999"},
                  ];
    [dataArray removeAllObjects];
    dataArray = [[NSMutableArray alloc] initWithArray:realArray];
    
//    CardView *cardView = [[CardView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 300)];
//    cardView.data = dataArray;
//    [self.view addSubview:cardView];
    
    DemoView *demoView = [[DemoView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 200)];
    demoView.backgroundColor = [UIColor redColor];
    demoView.data = dataArray;
    [self.view addSubview:demoView];
    
}





@end
