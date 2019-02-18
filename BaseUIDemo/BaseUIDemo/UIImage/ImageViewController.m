//
//  ImageViewController.m
//  BaseUIDemo
//
//  Created by mkrq-yh on 2019/1/9.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()

@property (nonatomic,strong) UIScrollView *scrollView;

@end

@implementation ImageViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kColorWhite;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, BarHeight, kScreenWidth, kScreenHeight-BarHeight)];
    self.scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight*3);
    [self.view addSubview:self.scrollView];
    
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self initPage];
}

- (void)initPage
{
    
    NSString *imgUrl = @"http://img1.ph.126.net/oW4ncJdpQRh8GaYvtWarJA==/4793800328459333539.jpg";
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *imgPath = [bundle pathForResource:@"img" ofType:@"png"];
    UIImage *imgg = [[UIImage alloc] initWithContentsOfFile:imgPath];

    UIImageView *img1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth, 100)];
    img1.image = imgg;
    [self.scrollView addSubview:img1];
    
    UIImageView *img2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 120, kScreenWidth, 100)];
    [img2 sd_setImageWithURL:[NSURL URLWithString:imgUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        NSLog(@"img2图片加载之后执行");
    }];
    [self.scrollView addSubview:img2];
    
    UIImageView *img3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 230, kScreenWidth, 100)];
    [img3 sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"img"]];
    [self.scrollView addSubview:img3];
    
    UIImageView *img4 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 340, kScreenWidth, 100)];
    [img4 sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"img"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        NSLog(@"img4图片加载之后执行");
    }];
    [self.scrollView addSubview:img4];
    
    UIImageView *img5 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 450, kScreenWidth, 100)];
    [img5 sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"img"] options:SDWebImageProgressiveDownload];
    [self.scrollView addSubview:img5];
    
    //模糊图片
    UIImageView *img6 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 560, kScreenWidth, 100)];
    [img6 sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"img"]];
    [self.scrollView addSubview:img6];
    // jpeg quality image data
    float quality = .01f;
    // intensity of blurred
    float blurred = .7f;
    NSData *imageData = UIImageJPEGRepresentation([img6 image], quality);
    UIImage *blurredImage = [[UIImage imageWithData:imageData] blurredImage:blurred];
    img6.image = blurredImage;
    
    //屏幕截图
    UIImageView *img7 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 670, kScreenWidth*0.4, kScreenHeight*0.4)];
    img7.layer.borderWidth = 1;
    [self.scrollView addSubview:img7];
    UIImage *image = [UIImage screenshot];
    img7.image = image;
    
    //根据颜色生成图片
    UIImageView *img8 = [[UIImageView alloc] initWithFrame:CGRectMake(0, img7.frame.origin.y+img7.frame.size.height+10, 200, 100)];
    img8.layer.borderWidth = 1;
    [self.scrollView addSubview:img8];
    UIColor *purpleColor = [UIColor colorWithRed:.927f green:.264f blue:.03f alpha:1];
    UIImage *img8_img = [UIImage imageWithColor:purpleColor];
    [img8 setImage:img8_img];

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
