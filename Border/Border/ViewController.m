//
//  ViewController.m
//  Border
//
//  Created by mkrq-yh on 2019/3/1.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scroll.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*2);
    [self.view addSubview:scroll];
    
    /*
     一般实线边框，四面都有
     */
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    view.backgroundColor = [UIColor yellowColor];
    view.layer.borderWidth = 2;//边粗细
    view.layer.borderColor = [[UIColor redColor] CGColor];//边框颜色
    [scroll addSubview:view];
    
    /*
     一般虚线边框，四面都有
    */
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(100, view.frame.origin.y+view.frame.size.height+50, 100, 100)];
    view2.backgroundColor = [UIColor yellowColor];
    view2.layer.cornerRadius = 10;
    view2.layer.masksToBounds = YES;
    [scroll addSubview:view2];

    CAShapeLayer *dottedLineBorder  = [[CAShapeLayer alloc] init];
    dottedLineBorder.frame = CGRectMake(0, 0, view2.frame.size.width, view2.frame.size.height);
    [dottedLineBorder setLineWidth:2];//虚线的宽度
    [dottedLineBorder setStrokeColor:[UIColor redColor].CGColor];//虚线的颜色
    [dottedLineBorder setFillColor:[UIColor clearColor].CGColor];//填充的颜色
    dottedLineBorder.lineDashPattern = @[@3,@5];//3 - 线段长度 ，5 － 线段与线段间距
//    UIBezierPath *path = [UIBezierPath bezierPathWithRect:dottedLineBorder.frame];//没有圆角时使用
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:view2.bounds cornerRadius:10];//有圆角时使用
    dottedLineBorder.path = path.CGPath;//设置路径
    [view2.layer addSublayer:dottedLineBorder];
    
    /*
     一般虚线边框，四面都有
     */
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(100, view2.frame.origin.y+view2.frame.size.height+50, 100, 100)];
    view3.backgroundColor = [UIColor yellowColor];
//    view3.layer.cornerRadius = 10;
//    view3.layer.masksToBounds = YES;
    [scroll addSubview:view3];
    [self setBorderWithView:view3 top:YES left:NO bottom:NO right:NO borderColor:[UIColor redColor] borderWidth:2];
    [self setBorderWithView:view3 top:NO left:YES bottom:NO right:NO borderColor:[UIColor greenColor] borderWidth:2];
    [self setBorderWithView:view3 top:NO left:NO bottom:YES right:NO borderColor:[UIColor purpleColor] borderWidth:2];
    [self setBorderWithView:view3 top:NO left:NO bottom:NO right:YES borderColor:[UIColor orangeColor] borderWidth:2];

}

- (void)setBorderWithView:(UIView *)view top:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width
{
    if (top) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, view.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (left) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, width, view.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (bottom) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, view.frame.size.height - width, view.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (right) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(view.frame.size.width - width, 0, width, view.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
}


@end
