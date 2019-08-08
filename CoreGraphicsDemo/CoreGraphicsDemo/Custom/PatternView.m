//
//  PatternView.m
//  CoreGraphicsDemo
//
//  Created by mkrq-yh on 2019/5/27.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "PatternView.h"

static const CGFloat patternCellW = 20;
static const CGFloat patternCellH = 20;
#define PSIZE 16

@implementation PatternView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self drawColorPatternWithRect:rect];
    
//    [self drawStencilPatternWithRect:rect];
}

void myDrawPattern(void *info, CGContextRef context){
    
    CGFloat w = 5;
    
    CGRect rect1 = CGRectMake(0, 0, w, w);
    CGRect rect2 = CGRectMake(w, 0, w, w);
    CGRect rect3 = CGRectMake(0, w, w, w);
    CGRect rect4 = CGRectMake(w, w, w, w);
    
    CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, patternCellW, patternCellH));
    
    CGContextSetRGBFillColor(context, 1, 0, 0, 0.5);
    CGContextFillRect(context, rect1);
    
    CGContextSetRGBFillColor(context, 0, 1, 1, 0.5);
    CGContextFillRect(context, rect2);
    
    CGContextSetRGBFillColor(context, 0, 0, 1, 0.5);
    CGContextFillRect(context, rect3);
    
    CGContextSetRGBFillColor(context, 0.5, 0.5, 0.5, 0.5);
    CGContextFillRect(context, rect4);
}

#pragma mark - color pattern
- (void)drawColorPatternWithRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat alpha = 1;
    
    CGContextSaveGState(context);
    
    //configure color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreatePattern(NULL);
    CGContextSetFillColorSpace(context, colorSpace);
    CGColorSpaceRelease(colorSpace);
    
    static const CGPatternCallbacks patternCallBacks = {0, &myDrawPattern, NULL};
    CGPatternRef pattern = CGPatternCreate(NULL,
                                           CGRectMake(0, 0, patternCellW, patternCellH),
                                           CGAffineTransformIdentity,
                                           patternCellW + 5,
                                           patternCellH + 5,
                                           kCGPatternTilingConstantSpacing,
                                           YES,
                                           &patternCallBacks);
    
    //draw
    CGContextSetFillPattern(context, pattern, &alpha);
    CGPatternRelease(pattern);
    CGContextFillRect(context, rect);
    CGContextRestoreGState(context);
}


static void drawStar (void *info, CGContextRef myContext)
{
    int k;
    double r, theta;
    
    r = 0.8 * PSIZE / 2;
    theta = 2 * M_PI * (2.0 / 5.0); // 144 degrees
    
    CGContextTranslateCTM (myContext, PSIZE/2, PSIZE/2);
    
    CGContextMoveToPoint(myContext, 0, r);
    for (k = 1; k < 5; k++) {
        CGContextAddLineToPoint (myContext,
                                 r * sin(k * theta),
                                 r * cos(k * theta));
    }
    CGContextClosePath(myContext);
    CGContextFillPath(myContext);
}

#pragma mark -  stencil pattern
- (void)drawStencilPatternWithRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGPatternRef pattern;
    CGColorSpaceRef baseSpace;
    CGColorSpaceRef patternSpace;
    static const CGFloat color[4] = { 0, 1, 0, 1 };
    static const CGPatternCallbacks callbacks = {0, &drawStar, NULL};
    
    baseSpace = CGColorSpaceCreateDeviceRGB ();
    patternSpace = CGColorSpaceCreatePattern (baseSpace);
    CGContextSetFillColorSpace (context, patternSpace);
    CGColorSpaceRelease (patternSpace);
    CGColorSpaceRelease (baseSpace);
    
    pattern = CGPatternCreate(NULL,
                              CGRectMake(0, 0, PSIZE, PSIZE),//每个pattern cell的尺寸
                              CGAffineTransformIdentity,
                              PSIZE,//每个cell之间需要有间隔，则需要传入cell宽或者高加上间隔距离
                              PSIZE,//每个cell之间需要有间隔，则需要传入cell宽或者高加上间隔距离
                              kCGPatternTilingConstantSpacing,
                              false,//表示是否是绘制color pattern
                              &callbacks);//最后一个参数是一个回调函数，每绘制一个cell会自动调用一次；所以还需要实现一个回调函数CGPatternCallbacks用于绘制cell
    CGContextSetFillPattern (context, pattern, color);
    CGPatternRelease (pattern);
    CGContextFillRect(context, rect);
    
}


@end
