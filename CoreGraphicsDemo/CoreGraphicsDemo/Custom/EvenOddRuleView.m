//
//  EvenOddRuleView.m
//  CoreGraphicsDemo
//
//  Created by mkrq-yh on 2019/5/27.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "EvenOddRuleView.h"

@implementation EvenOddRuleView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBFillColor(context, 1, 0, 0, 1);
    CGContextSetRGBStrokeColor(context, 0, 1, 0, 1);
    CGContextAddEllipseInRect(context, CGRectMake(0, 0, rect.size.width, rect.size.height));
    CGContextAddEllipseInRect(context, CGRectMake(50, 50, rect.size.width - 50 * 2, rect.size.height - 50 * 2));
    CGContextAddEllipseInRect(context, CGRectMake(80, 80, rect.size.width - 80 * 2, rect.size.height - 80 * 2));
    
    CGContextDrawPath(context, kCGPathEOFillStroke);

}


@end
