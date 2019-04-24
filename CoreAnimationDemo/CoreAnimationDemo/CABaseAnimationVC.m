//
//  CABaseAnimationVC.m
//  CoreAnimationDemo
//
//  Created by mkrq-yh on 2019/4/23.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "CABaseAnimationVC.h"
#import "animation.h"

@interface CABaseAnimationVC ()

@property (nonatomic,strong) UIImageView *demoImgView;

@end

@implementation CABaseAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"CABaseAnimation 基本使用";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.demoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 100, 100, 100)];
    self.demoImgView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.demoImgView];
    
    NSArray *array = @[@"位移",@"缩放",@"旋转",@"透明度",@"背景色",@"圆角",@"内容",@"边框",@"阴影颜色",@"阴影偏移",@"阴影透明度",@"阴影圆角"];
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
    
    /*
     重要属性
     fromValue ： keyPath对应的初始值
     toValue ： keyPath对应的结束值
     
     fillMode: 该属性定义了你的动画在开始和结束时的动作。默认值是 kCAFillModeRemoved
         kCAFillModeRemoved 设置为该值，动画将在设置的 beginTime 开始执行（如没有设置beginTime属性，则动画立即执行），动画执行完成后将会layer的改变恢复原状
         kCAFillModeForwards 设置为该值，动画即使之后layer的状态将保持在动画的最后一帧，而removedOnCompletion的默认属性值是 YES，所以为了使动画结束之后layer保持结束状态，应将removedOnCompletion设置为NO
         kCAFillModeBackwards 设置为该值，将会立即执行动画的第一帧，不论是否设置了 beginTime属性。观察发现，设置该值，刚开始视图不见，还不知道应用在哪里
         kCAFillModeBoth 该值是 kCAFillModeForwards 和 kCAFillModeBackwards的组合状态
     
     timingFunction: 设置动画的速度变化
         kCAMediaTimingFunctionLinear 在整个动画时间内动画都是以一个相同的速度来改变。也就是匀速运动
         kCAMediaTimingFunctionEaseIn 动画开始时会较慢，之后动画会加速
         kCAMediaTimingFunctionEaseOut 动画在开始时会较快，之后动画速度减慢。
         kCAMediaTimingFunctionEaseInEaseOut 动画在开始和结束时速度较慢，中间时间段内速度较快。
         kCAMediaTimingFunctionDefault
     
     基础动画主要提供了对于CALayer对象中的可变属性进行简单动画的操作。
     比如：位移、缩放、旋转、CGRect、透明度、背景颜色、圆角、边框、偏移、阴影等等
     
     注意点
     如果fillMode=kCAFillModeForwards 和 removedOnComletion=NO，
     那么在动画执行完毕后，图层会保持显示动画执行后的状态。
     但在实质上，图层的属性值还是动画执行前的初始值，并没有真正被改变。
     
     为什么动画结束后返回原状态？
     首先我们需要搞明白一点的是，layer动画运行的过程是怎样的？其实在我们给一个视图添加layer动画时，真正移动并不是我们的视图本身，而是 presentation layer 的一个缓存。动画开始时 presentation layer开始移动，原始layer隐藏，动画结束时，presentation layer从屏幕上移除，原始layer显示。这就解释了为什么我们的视图在动画结束后又回到了原来的状态，因为它根本就没动过。
     
     在动画执行完成之后，最好还是将动画移除掉。也就是尽量不要设置removedOnCompletion属性为NO
     fillMode尽量取默认值就好了，不要去设置它的值。只有在极个别的情况下我们会修改它的值，以后会说到，这里先占个坑。
     解决有时视图会闪动一下的问题，我们可以将layer的属性值设置为我们的动画最后要达到的值，然后再给我们的视图添加layer动画
     
     */
}

- (void)btnClick:(UIButton *)sender
{
//    NSArray *array = @[@"位移",@"缩放",@"旋转",@"透明度",@"背景色",@"圆角",@"内容",@"边框",@"阴影颜色",@"阴影偏移",@"阴影透明度",@"阴影圆角"];
    if (sender.tag == 0) {//位移
        [self animationPositon];
    } else if (sender.tag == 1) {//缩放
        [self animationScale];
    } else if (sender.tag == 2) {//旋转
        [self animationTransform];
    } else if (sender.tag == 3) {//透明度
        [self animationOpacity];
    } else if (sender.tag == 4) {//背景色
        [self animationBackgroundColor];
    } else if (sender.tag == 5) {//圆角
        [self animationCornerRadius];
    } else if (sender.tag == 6) {//内容
        [self animationContents];
    } else if (sender.tag == 7) {//边框
        [self animationBorderWidth];
    } else if (sender.tag == 8) {//阴影颜色
        [self animationShadowColor];
    } else if (sender.tag == 9) {//阴影偏移
        [self animationShadowOffset];
    } else if (sender.tag == 10) {//阴影透明度
        [self animationShadowOpacity];
    } else if (sender.tag == 11) {//阴影圆角
        [self animationShadowRadius];
    } else {
        
    }

//
//    //透明度
//    CABasicAnimation *anima4 = [CABasicAnimation animationWithKeyPath:kCAOpacity];
//    anima4.fromValue = [NSNumber numberWithFloat:1.0];
//    anima4.toValue = [NSNumber numberWithFloat:0.3];
//    anima4.duration = 1.0;
//    anima4.fillMode = kCAFillModeForwards;
//    anima4.removedOnCompletion = NO;
//    [self.demoView.layer addAnimation:anima4 forKey:@"opacityAnimation"];
//

}

#pragma mark 位移
- (void)animationPositon {
    //位移
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:kCAPosition];
    anima.fromValue = [NSValue valueWithCGPoint:self.demoImgView.layer.position];
    anima.toValue = [NSValue valueWithCGPoint:CGPointMake(300, 300)];
    anima.duration = 4.0;
    anima.beginTime = CACurrentMediaTime()+1.0;
//    anima.repeatCount = 1;
//    anima.autoreverses = YES;
    anima.speed = 2;
    anima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];;
    [self.demoImgView.layer addAnimation:anima forKey:@"positionAnimation"];
    
//    //位移x
//    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:kCAPositionX];
//    anima.fromValue = [NSNumber numberWithFloat:self.demoImgView.layer.position.x];
//    anima.toValue = [NSNumber numberWithFloat:self.demoImgView.layer.position.x+100];
//    anima.duration = 4.0;
//    anima.speed = 2;
//    anima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];;
//    [self.demoImgView.layer addAnimation:anima forKey:@"positionAnimation"];
    
//    //位移y
//    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:kCAPositionY];
//    anima.fromValue = [NSNumber numberWithFloat:self.demoImgView.layer.position.y];
//    anima.toValue = [NSNumber numberWithFloat:self.demoImgView.layer.position.y+100];
//    anima.duration = 4.0;
//    anima.speed = 2;
//    anima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];;
//    [self.demoImgView.layer addAnimation:anima forKey:@"positionAnimation"];
}

#pragma mark - 缩放
- (void)animationScale {
    //缩放
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:kCAScale];
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    animation.toValue = [NSNumber numberWithFloat:0.5];
    animation.duration = 3.0;
    [self.demoImgView.layer addAnimation:animation forKey:@"scaleAnimation"];
    
//    //缩放x
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:kCAScaleX];
//    animation.fromValue = [NSNumber numberWithFloat:1.0];
//    animation.toValue = [NSNumber numberWithFloat:0.5];
//    animation.duration = 3.0;
//    [self.demoImgView.layer addAnimation:animation forKey:@"scaleXAnimation"];
    
//    //缩放y
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:kCAScaleY];
//    animation.fromValue = [NSNumber numberWithFloat:1.0];
//    animation.toValue = [NSNumber numberWithFloat:0.5];
//    animation.duration = 3.0;
//    [self.demoImgView.layer addAnimation:animation forKey:@"scaleYAnimation"];
}

#pragma mark - 旋转
- (void)animationTransform {
//    //旋转
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:kCARotation];
//    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0, 0, 0)];//绕着矢量（x,y,z）旋转
//    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 0, 1)];//绕着矢量（x,y,z）旋转
//    [self.demoImgView.layer addAnimation:animation forKey:@"transformAnimation"];
    
//    //旋转x
//    CABasicAnimation *anima3 = [CABasicAnimation animationWithKeyPath:kCARotationX];
//    anima3.fromValue = [NSNumber numberWithFloat:0];
//    anima3.toValue = [NSNumber numberWithFloat:M_PI];
//    anima3.duration = 3.0;
//    [self.demoImgView.layer addAnimation:anima3 forKey:@"routationX"];
    
//    //旋转y
//    CABasicAnimation *anima3 = [CABasicAnimation animationWithKeyPath:kCARotationY];
//    anima3.fromValue = [NSNumber numberWithFloat:0];
//    anima3.toValue = [NSNumber numberWithFloat:M_PI];
//    anima3.duration = 3.0;
//    [self.demoImgView.layer addAnimation:anima3 forKey:@"routationY"];
    
    //旋转x
    CABasicAnimation *anima3 = [CABasicAnimation animationWithKeyPath:kCARotationZ];
    anima3.fromValue = [NSNumber numberWithFloat:0];
    anima3.toValue = [NSNumber numberWithFloat:M_PI*2];
    anima3.duration = 3.0;
    [self.demoImgView.layer addAnimation:anima3 forKey:@"routationZ"];

}

#pragma mark - 透明度
- (void)animationOpacity {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:kCAOpacity];
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    animation.toValue = [NSNumber numberWithFloat:0.3];
    animation.duration = 3.0;
    [self.demoImgView.layer addAnimation:animation forKey:@"opacityAnimation"];
}

#pragma mark - 背景颜色
- (void)animationBackgroundColor {
    //颜色
    CABasicAnimation *anima5 = [CABasicAnimation animationWithKeyPath:kCABackgroundColor];
    anima5.fromValue = (__bridge id _Nullable)([UIColor greenColor].CGColor);
    anima5.toValue = (__bridge id _Nullable)([UIColor redColor].CGColor);
    anima5.duration = 3;
    [self.demoImgView.layer addAnimation:anima5 forKey:@"backgroundColorAnimation"];
}

#pragma mark - 圆角
- (void)animationCornerRadius {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:kCACornerRadius];
    animation.fromValue = [NSNumber numberWithFloat:0.f];
    animation.toValue = [NSNumber numberWithFloat:self.demoImgView.frame.size.height/2];
    animation.duration = 3;
    animation.repeatCount = 1;
    [self.demoImgView.layer addAnimation:animation forKey:@"cornerRadiusAnimation"];
}

#pragma mark - 内容
- (void)animationContents {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:kCAContents];
    animation.fromValue = (id)[UIImage imageNamed:@"123"].CGImage;
    animation.toValue = (id)[UIImage imageNamed:@"456"].CGImage;
    animation.duration = 3;
    animation.repeatCount = 1;
    [self.demoImgView.layer addAnimation:animation forKey:@"contentsAnimation"];
}

#pragma mark - 边框
- (void)animationBorderWidth {
    self.demoImgView.layer.borderWidth = 1.0;
    self.demoImgView.layer.borderColor = [UIColor purpleColor].CGColor;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:kCABorderWidth];
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    animation.toValue = [NSNumber numberWithFloat:5.0];
    animation.duration = 3;
    animation.repeatCount = 1;
    [self.demoImgView.layer addAnimation:animation forKey:@"BorderWidthAnimation"];
}

#pragma mark - 阴影颜色
- (void)animationShadowColor {
    self.demoImgView.layer.borderWidth = 1.0;
    self.demoImgView.layer.borderColor = [UIColor purpleColor].CGColor;
    
    [self.demoImgView.layer setShadowOffset:CGSizeMake(5,5)];
    [self.demoImgView.layer setShadowOpacity:1];
    [self.demoImgView.layer setShadowColor:[UIColor grayColor].CGColor];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:kCAShadowColor];
    animation.fromValue = (__bridge id _Nullable)([UIColor greenColor].CGColor);;
    animation.toValue = (__bridge id _Nullable)([UIColor redColor].CGColor);;
    animation.duration = 2;
    animation.repeatCount = CGFLOAT_MAX;
    animation.autoreverses = YES;
    [self.demoImgView.layer addAnimation:animation forKey:@"ShadowColorAnimation"];
}

#pragma mark - 阴影偏移量
- (void)animationShadowOffset {
    self.demoImgView.layer.borderWidth = 1.0;
    self.demoImgView.layer.borderColor = [UIColor purpleColor].CGColor;
    
    [self.demoImgView.layer setShadowOffset:CGSizeMake(0,0)];
    [self.demoImgView.layer setShadowOpacity:1];
    [self.demoImgView.layer setShadowColor:[UIColor grayColor].CGColor];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:kCAShadowOffset];
    animation.fromValue = [NSValue valueWithCGSize:CGSizeMake(0,0)];;
    animation.toValue = [NSValue valueWithCGSize:CGSizeMake(10,10)];;
    animation.duration = 2;
    animation.repeatCount = CGFLOAT_MAX;
    animation.autoreverses = YES;
    [self.demoImgView.layer addAnimation:animation forKey:@"ShadowOffsetAnimation"];
}

#pragma mark - 阴影透明度
- (void)animationShadowOpacity {
    self.demoImgView.layer.borderWidth = 1.0;
    self.demoImgView.layer.borderColor = [UIColor purpleColor].CGColor;
    
    [self.demoImgView.layer setShadowOffset:CGSizeMake(0,0)];
    [self.demoImgView.layer setShadowOpacity:1];
    [self.demoImgView.layer setShadowColor:[UIColor redColor].CGColor];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:kCAShadowOpacity];
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    animation.toValue = [NSNumber numberWithFloat:0.3];
    animation.duration = 2;
    animation.repeatCount = CGFLOAT_MAX;
    animation.autoreverses = YES;
    [self.demoImgView.layer addAnimation:animation forKey:@"ShadowOpacityAnimation"];
}

#pragma mark - 阴影圆角
- (void)animationShadowRadius {
    self.demoImgView.layer.borderWidth = 1.0;
    self.demoImgView.layer.borderColor = [UIColor purpleColor].CGColor;
    
    [self.demoImgView.layer setShadowOffset:CGSizeMake(0,0)];
    [self.demoImgView.layer setShadowOpacity:1];
    [self.demoImgView.layer setShadowColor:[UIColor redColor].CGColor];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:kCAShadowRadius];
    animation.fromValue = [NSNumber numberWithFloat:5];
    animation.toValue = [NSNumber numberWithFloat:20];
    animation.duration = 2;
    animation.repeatCount = 1;
    [self.demoImgView.layer addAnimation:animation forKey:@"ShadowRadiusAnimation"];
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
