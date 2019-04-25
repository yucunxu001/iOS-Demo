//
//  DWMenuButton.m
//  CoreAnimationDemo
//
//  Created by mkrq-yh on 2019/4/25.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "DWMenuButton.h"

@interface DWMenuButton()<UIGestureRecognizerDelegate>

@property (nonatomic, assign) BOOL isOpen;//判断是否展开
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic, strong) NSMutableArray *buttonContainer;
@property (nonatomic, assign) CGRect originFrame;//保存self初始frame

@end

@implementation DWMenuButton

- (instancetype)initWithFrame:(CGRect)frame withDirection:(ExpansionDirection)direction
{
    self = [super initWithFrame:frame];
    if (self) {
        _direction = direction;
        [self settingDefault];
    }
    return self;
}

#pragma mark - 默认设置
- (void)settingDefault {
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    //默认设置
    self.originFrame = self.frame;
    self.isOpen = NO;
    self.buttonSpacing = 20;
    self.time = 0.25;
    self.userInteractionEnabled = YES;
    //添加点击事件
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    self.tapGestureRecognizer.cancelsTouchesInView = NO;
    self.tapGestureRecognizer.delegate = self;
    [self addGestureRecognizer:self.tapGestureRecognizer];
}

- (void)setHomeButtonView:(UIView *)homeButtonView {
    if (_homeButtonView != homeButtonView) {
        _homeButtonView = homeButtonView;
    }
    if ([_homeButtonView isDescendantOfView:self] == NO) {
        [self addSubview:_homeButtonView];
    }
}

#pragma mark - 添加buttons
- (void)addButtons:(NSArray *)buttons {
    assert(buttons != nil);
    for (UIButton *button in buttons) {
        [self addButton:button];
    }
    
    if (self.homeButtonView != nil) {
        [self bringSubviewToFront:self.homeButtonView];
    }
}
#pragma mark - 添加单个button
- (void)addButton:(UIButton *)button {
    assert(button != nil);
    if (_buttonContainer == nil) {
        self.buttonContainer = [[NSMutableArray alloc] init];
    }
    
    if ([_buttonContainer containsObject:button] == false) {
        [_buttonContainer addObject:button];
        [self addSubview:button];
        button.hidden = YES;
    }
}
#pragma mark - 展开显示button
- (void)showButtons {
    NSLog(@"展开显示");
    self.userInteractionEnabled = NO;

    [self changeOpenFrame];
    [CATransaction begin];
    [CATransaction setAnimationDuration:_time];
    [CATransaction setCompletionBlock:^{
        for (UIButton *button in self->_buttonContainer) {
            button.transform = CGAffineTransformIdentity;
        }
        self.userInteractionEnabled = YES;
    }];
    
    NSArray *buttonContainer = _buttonContainer;
    if (self.direction == DirectionUp || self.direction == DirectionLeft) {
        buttonContainer = [self reverseFromArray:_buttonContainer];
    }
    
    for (int i = 0; i < buttonContainer.count; i++) {
        int index = (int)buttonContainer.count - (i + 1);
        UIButton *button = [buttonContainer objectAtIndex:index];
        button.layer.position = self.homeButtonView.layer.position;
        button.hidden = NO;

        CGPoint originPosition = CGPointZero;
        CGPoint finalPosition = CGPointZero;
        
        switch (self.direction) {
            case DirectionUp:
            {
                originPosition = CGPointMake(self.frame.size.width/2.0, self.frame.size.height-self.homeButtonView.frame.size.height);
                finalPosition = CGPointMake(self.frame.size.width/2.0, self.frame.size.height-self.homeButtonView.frame.size.height-self.buttonSpacing-button.frame.size.height/2.0-(button.frame.size.height+self.buttonSpacing)*index);
            }
                break;
            case DirectionDown:
            {
                originPosition = CGPointMake(self.frame.size.width/2.0, self.homeButtonView.frame.size.height);
                finalPosition = CGPointMake(self.frame.size.width/2.0,
                                            self.homeButtonView.frame.size.height+self.buttonSpacing+button.frame.size.height/2.0+(button.frame.size.height+self.buttonSpacing)*index);
            }
                break;
            case DirectionLeft:
            {
                originPosition = CGPointMake(self.frame.size.width-self.homeButtonView.frame.size.width, self.frame.size.height/2);
                finalPosition = CGPointMake(self.frame.size.width-self.homeButtonView.frame.size.width-button.frame.size.width/2.0-self.buttonSpacing-(button.frame.size.width+self.buttonSpacing)*index, self.frame.size.height/2);
            }
                break;
            case DirectionRight:
            {
                originPosition = CGPointMake(self.homeButtonView.frame.size.width, self.frame.size.height/2);
                finalPosition = CGPointMake(self.homeButtonView.frame.size.width+button.frame.size.width/2.0+self.buttonSpacing+(button.frame.size.width+self.buttonSpacing)*index, self.frame.size.height/2);
            }
                break;
                
            default:
                break;
        }

        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
        animation.fromValue = [NSValue valueWithCGPoint:originPosition];
        animation.toValue = [NSValue valueWithCGPoint:finalPosition];
        animation.duration = _time;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.beginTime = CACurrentMediaTime() + (_time/(float)_buttonContainer.count * (float)i);
        animation.fillMode = kCAFillModeForwards;
        animation.removedOnCompletion = NO;
        [button.layer addAnimation:animation forKey:@"positionAnimation"];
        
        button.layer.position = finalPosition;

        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.fromValue = [NSNumber numberWithFloat:0.01f];
        scaleAnimation.toValue = [NSNumber numberWithFloat:1.0f];
        scaleAnimation.duration = _time;
        scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        scaleAnimation.beginTime = CACurrentMediaTime() + (_time/(float)_buttonContainer.count * (float)i);
        scaleAnimation.fillMode = kCAFillModeForwards;
        scaleAnimation.removedOnCompletion = NO;
        [button.layer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
        
        button.transform = CGAffineTransformMakeScale(0.01f, 0.01f);

    }
    
    [CATransaction commit];
    _isOpen = YES;

}
#pragma mark - 收起隐藏button
- (void)dismissButtons {
    NSLog(@"收起隐藏");
    self.userInteractionEnabled = NO;
    [CATransaction begin];
    [CATransaction setAnimationDuration:_time];
    [CATransaction setCompletionBlock:^{
        self.frame = self.originFrame;
        for (UIButton *button in self->_buttonContainer) {
            button.transform = CGAffineTransformIdentity;
            button.hidden = YES;
        }
        self.userInteractionEnabled = YES;
    }];
    
    int index = 0;
    for (int i = (int)_buttonContainer.count-1 ; i >= 0; i--) {
        UIButton *button = [_buttonContainer objectAtIndex:i];
        //在向下和向右重新获取button
        if (self.direction == DirectionDown || self.direction == DirectionRight) {
            button = [_buttonContainer objectAtIndex:index];
        }
        CGPoint originPosition = CGPointZero;
        CGPoint finalPosition = CGPointZero;
        
        switch (self.direction) {
            case DirectionUp:
            {
                originPosition = button.layer.position;
                finalPosition = CGPointMake(self.frame.size.width/2.f, self.frame.size.height - self.homeButtonView.frame.size.height);

            }
                break;
            case DirectionDown:
            {
                originPosition = button.layer.position;
                finalPosition = CGPointMake(self.frame.size.width/2.f, self.homeButtonView.frame.size.height);
            }
                break;
            case DirectionLeft:
            {
                originPosition = button.layer.position;
                finalPosition = CGPointMake(self.frame.size.width-self.homeButtonView.frame.size.width, self.frame.size.height/2.0);
            }
                break;
            case DirectionRight:
            {
                originPosition = button.layer.position;
                finalPosition = CGPointMake(self.homeButtonView.frame.size.width, self.frame.size.height/2.0);
            }
                break;
                
            default:
                break;
        }
        
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
        scaleAnimation.toValue = [NSNumber numberWithFloat:0.01f];
        scaleAnimation.duration = _time;
        scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        scaleAnimation.beginTime = CACurrentMediaTime() + (_time/(float)_buttonContainer.count * (float)index) + 0.03;
        scaleAnimation.fillMode = kCAFillModeForwards;
        scaleAnimation.removedOnCompletion = NO;
        [button.layer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
        
        button.transform = CGAffineTransformMakeScale(1.f, 1.f);

        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
        animation.fromValue = [NSValue valueWithCGPoint:originPosition];
        animation.toValue = [NSValue valueWithCGPoint:finalPosition];
        animation.duration = _time;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.beginTime = CACurrentMediaTime() + (_time/(float)_buttonContainer.count * (float)index);
        animation.fillMode = kCAFillModeForwards;
        animation.removedOnCompletion = NO;
        [button.layer addAnimation:animation forKey:@"positionAnimation"];
        
        button.layer.position = originPosition;

        index++;
    }
    
    [CATransaction commit];
    _isOpen = NO;

}
#pragma mark - 展开时self的frame
- (void)changeOpenFrame {
    CGFloat buttonWidth = [self combinedButtonWidth];
    CGFloat buttonHeight = [self combinedButtonHeight];
    switch (self.direction) {
        case DirectionUp:
        {
            self.homeButtonView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;//自动调整与superView顶部的距离，保证与superView底部的距离不变。
            CGRect frame = self.frame;
            frame.origin.y -= buttonHeight;
            frame.size.height += buttonHeight;
            self.frame = frame;
        }
            break;
        case DirectionDown:
        {
            self.homeButtonView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;//自动调整与superView底部的距离，也就是说，与superView顶部的距离不变。
            CGRect frame = self.frame;
            frame.size.height += buttonHeight;
            self.frame = frame;
        }
            break;
        case DirectionLeft:
        {
            self.homeButtonView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;//自动调整与superView左边的距离，保证与superView右边的距离不变。
            CGRect frame = self.frame;
            frame.origin.x -= buttonWidth;
            frame.size.width += buttonWidth;
            self.frame = frame;
        }
            break;
        case DirectionRight:
        {
            self.homeButtonView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;//自动调整与superView的右边距离，保证与superView左边的距离不变。
            CGRect frame = self.frame;
            frame.size.width += buttonWidth;
            self.frame = frame;
        }
            break;
            
        default:
            break;
    }
}
#pragma mark - 计算buttons宽度
- (CGFloat)combinedButtonWidth {
    CGFloat width = 0;
    for (UIButton *button in _buttonContainer) {
        width += button.frame.size.width+_buttonSpacing;
    }
    return width;
}
#pragma mark - 计算buttons高度
- (CGFloat)combinedButtonHeight {
    CGFloat height = 0;
    for (UIButton *button in _buttonContainer) {
        height += button.frame.size.height+_buttonSpacing;
    }
    return height;
}
#pragma mark - 倒叙遍历数组
- (NSArray *)reverseFromArray:(NSArray *)array {
    NSMutableArray *reverseArray = [NSMutableArray array];
    for (int i = (int)array.count - 1; i >= 0; i--) {
        [reverseArray addObject:[array objectAtIndex:i]];
    }
    return reverseArray;
}

- (void)setTime:(float)time {
    _time = time;
}

- (void)setButtonSpacing:(CGFloat)buttonSpacing {
    _buttonSpacing = buttonSpacing;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    if (CGRectContainsPoint(self.homeButtonView.frame, touchLocation)) {
        if (_isOpen) {
            [self dismissButtons];
        } else {
            [self showButtons];
        }
    }
}

#pragma mark - 点击事件
- (void)handleTapGesture:(id)sender {
    if (self.tapGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint touchLocation = [self.tapGestureRecognizer locationOfTouch:0 inView:self];
        if (_isOpen == YES && CGRectContainsPoint(self.homeButtonView.frame, touchLocation) == false) {
            [self dismissButtons];
        }
    }
}

#pragma mark UIGestureRecognizer Delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    CGPoint touchLocation = [touch locationInView:self];
    if ([self subviewForPoint:touchLocation] != self) {
        return YES;
    }
    return NO;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if ([self isUserInteractionEnabled]) {
        UIView *hitView = [super hitTest:point withEvent:event];
        if (hitView != self) {
            if (!_isOpen) {
                return self;
            } else {
                return [self subviewForPoint:point];
            }
        }
        return hitView;
    } else {
        return nil;
    }
}

- (UIView *)subviewForPoint:(CGPoint)point {
    for (UIView *subview in self.subviews) {
        if (CGRectContainsPoint(subview.frame, point)) {
            if (subview == self.homeButtonView) {
                return self;
            }
            else {
                return subview;
            }
        }
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
