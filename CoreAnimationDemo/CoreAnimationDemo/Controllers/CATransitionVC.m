//
//  CATransitionVC.m
//  CoreAnimationDemo
//
//  Created by mkrq-yh on 2019/4/23.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "CATransitionVC.h"
#import "animation.h"

#define RandomColor     [UIColor colorWithRed:(arc4random()%255)/255.0 green:(arc4random()%255)/255.0 blue:(arc4random()%255)/255.0 alpha:1.0]

@interface CATransitionVC ()

@property (nonatomic,strong) UILabel *demoLb;

@end

@implementation CATransitionVC
{
    int currentPage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"CATransition 基本使用";
    self.view.backgroundColor = [UIColor whiteColor];
    currentPage = 1;
    
    self.demoLb = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width-200)/2, 100, 200, 200)];
    self.demoLb.text = [NSString stringWithFormat:@"%d",currentPage];
    self.demoLb.textColor = [UIColor whiteColor];
    self.demoLb.textAlignment = NSTextAlignmentCenter;
    self.demoLb.font = [UIFont systemFontOfSize:40];
    self.demoLb.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.demoLb];
    
    NSArray *array = [NSArray arrayWithObjects:@"fade",@"moveIn",@"push",@"reveal",@"cube",@"suck",@"oglFlip",@"ripple",@"Curl",@"UnCurl",@"caOpen",@"caClose", nil];
    CGFloat width = (self.view.frame.size.width-100)/4;
    for (int i = 0; i < array.count; i++) {
        int x = i % 4;
        int y = i / 4;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame =  CGRectMake(20+x*(width+20), 400+y*70, width, 50);
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.backgroundColor = [UIColor grayColor];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }

}

- (void)chageDemoLb {
    currentPage++;
    self.demoLb.text = [NSString stringWithFormat:@"%d",currentPage];
    self.demoLb.backgroundColor = RandomColor;
}

- (void)btnClick:(UIButton *)sender {
    
    /*
        type值
        kCATransitionFade 渐变
        kCATransitionMoveIn 覆盖
        kCATransitionPush 推出
        kCATransitionReveal 揭开

        除此之外，该type还支持如下私有动画
        cube 立方体旋转
        suckEffect  收缩动画
        oglFlip  翻转
        rippleEffect  水波动画
        pageCurl  页面揭开
        pageUnCurl 放下页面
        cemeraIrisHollowOpen  镜头打开 不支持过渡方向
        cameraIrisHollowClose 镜头关闭 不支持过渡方向
     */
    
    /*
        subtype
        kCATransitionFromRight
        kCATransitionFromLeft
        kCATransitionFromTop
        kCATransitionFromBottom
     */
    [self chageDemoLb];
    if (sender.tag == 0) {//fade
        [self typeFade];
    } else if (sender.tag == 1) {//moveIn
        [self typeMoveIn];
    } else if (sender.tag == 2) {//push
        [self typePush];
    } else if (sender.tag == 3) {//reveal
        [self typeReveal];
    } else if (sender.tag == 4) {//cube
        [self typeCube];
    } else if (sender.tag == 5) {//suck
        [self typeSuckEffect];
    } else if (sender.tag == 6) {//oglFlip
        [self typeOglFlip];
    } else if (sender.tag == 7) {//ripple
        [self typeRippleEffect];
    } else if (sender.tag == 8) {//Curl
        [self typePageCurl];
    } else if (sender.tag == 9) {//UnCurl
        [self typePageUnCurl];
    } else if (sender.tag == 10) {//caOpen
        [self typeCameraIrisHollowOpen];
    } else if (sender.tag == 11) {//caClose
        [self typeCameraIrisHollowClose];
    }
    
}

#pragma mark - kCATransitionFade 渐变
- (void)typeFade {
    CATransition *animation = [CATransition animation];
    //设置动画的过渡方式
    animation.type = kCATransitionFade;
    //设置动画的过渡方向
    animation.subtype = kCATransitionFromLeft;
    //设置动画时长
    animation.duration = 1.0;
    [self.demoLb.layer addAnimation:animation forKey:@"fadeAnimation"];
}

#pragma mark - kCATransitionMoveIn 覆盖
- (void)typeMoveIn {
    CATransition *animation = [CATransition animation];
    //设置动画的过渡方式
    animation.type = kCATransitionMoveIn;
    //设置动画的过渡方向
    animation.subtype = kCATransitionFromLeft;
    //设置动画时长
    animation.duration = 1.0;
    [self.demoLb.layer addAnimation:animation forKey:@"MoveInAnimation"];
}

#pragma mark - kCATransitionPush 推出
- (void)typePush {
    CATransition *animation = [CATransition animation];
    //设置动画的过渡方式
    animation.type = kCATransitionPush;
    //设置动画的过渡方向
    animation.subtype = kCATransitionFromLeft;
    //设置动画时长
    animation.duration = 1.0;
    [self.demoLb.layer addAnimation:animation forKey:@"PushAnimation"];
}

#pragma mark - kCATransitionReveal 揭开
- (void)typeReveal {
    CATransition *animation = [CATransition animation];
    //设置动画的过渡方式
    animation.type = kCATransitionReveal;
    //设置动画的过渡方向
    animation.subtype = kCATransitionFromLeft;
    //设置动画时长
    animation.duration = 1.0;
    [self.demoLb.layer addAnimation:animation forKey:@"RevealAnimation"];
}

#pragma mark - cube 立方体旋转
- (void)typeCube {
    CATransition *animation = [CATransition animation];
    //设置动画的过渡方式
    animation.type = @"cube";
    //设置动画的过渡方向
    animation.subtype = kCATransitionFromLeft;
    //设置动画时长
    animation.duration = 1.0;
    [self.demoLb.layer addAnimation:animation forKey:@"CubeAnimation"];
}

#pragma mark - suckEffect  收缩动画
- (void)typeSuckEffect {
    CATransition *animation = [CATransition animation];
    //设置动画的过渡方式
    animation.type = @"suckEffect";
    //设置动画的过渡方向
    animation.subtype = kCATransitionFromLeft;
    //设置动画时长
    animation.duration = 1.0;
    [self.demoLb.layer addAnimation:animation forKey:@"suckEffectAnimation"];
}

#pragma mark - oglFlip  翻转
- (void)typeOglFlip {
    CATransition *animation = [CATransition animation];
    //设置动画的过渡方式
    animation.type = @"oglFlip";
    //设置动画的过渡方向
    animation.subtype = kCATransitionFromLeft;
    //设置动画时长
    animation.duration = 1.0;
    [self.demoLb.layer addAnimation:animation forKey:@"oglFlipAnimation"];
}

#pragma mark - rippleEffect  水波动画
- (void)typeRippleEffect {
    self.demoLb.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"123"]];
    CATransition *animation = [CATransition animation];
    //设置动画的过渡方式
    animation.type = @"rippleEffect";
    //设置动画的过渡方向
//    animation.subtype = kCATransitionFromLeft;
    //设置动画时长
    animation.duration = 1.0;
    [self.demoLb.layer addAnimation:animation forKey:@"rippleEffectAnimation"];
}

#pragma mark - pageCurl  页面揭开 类似翻书
- (void)typePageCurl {
    CATransition *animation = [CATransition animation];
    //设置动画的过渡方式
    animation.type = @"pageCurl";
    //设置动画的过渡方向
    animation.subtype = kCATransitionFromLeft;
    //设置动画时长
    animation.duration = 1.0;
    [self.demoLb.layer addAnimation:animation forKey:@"pageCurlAnimation"];
}

#pragma mark - pageUnCurl  页面揭开 类似翻书
- (void)typePageUnCurl {
    CATransition *animation = [CATransition animation];
    //设置动画的过渡方式
    animation.type = @"pageUnCurl";
    //设置动画的过渡方向
    animation.subtype = kCATransitionFromLeft;
    //设置动画时长
    animation.duration = 1.0;
    [self.demoLb.layer addAnimation:animation forKey:@"pageUnCurlAnimation"];
}

#pragma mark - cameraIrisHollowOpen 镜头打开 不支持过渡方向
- (void)typeCameraIrisHollowOpen {
    CATransition *animation = [CATransition animation];
    //设置动画的过渡方式
    animation.type = @"cameraIrisHollowOpen";
    //设置动画的过渡方向
    animation.subtype = kCATransitionFromLeft;
    //设置动画时长
    animation.duration = 1.0;
    [self.demoLb.layer addAnimation:animation forKey:@"cameraIrisHollowOpenAnimation"];
}

#pragma mark - cameraIrisHollowOpen 镜头打开 不支持过渡方向
- (void)typeCameraIrisHollowClose {
    CATransition *animation = [CATransition animation];
    //设置动画的过渡方式
    animation.type = @"cameraIrisHollowClose";
    //设置动画的过渡方向
    animation.subtype = kCATransitionFromLeft;
    //设置动画时长
    animation.duration = 1.0;
    [self.demoLb.layer addAnimation:animation forKey:@"cameraIrisHollowCloseAnimation"];
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
