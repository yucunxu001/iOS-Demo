//
//  DWMenuButton.h
//  CoreAnimationDemo
//
//  Created by mkrq-yh on 2019/4/25.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,ExpansionDirection) {
    DirectionLeft = 0,
    DirectionRight,
    DirectionUp,
    DirectionDown
};

@interface DWMenuButton : UIView

@property (nonatomic, weak, readonly) NSArray *buttons;//展开显示的button
@property (nonatomic, strong) UIView *homeButtonView;//默认显示button
@property (nonatomic,assign) CGFloat buttonSpacing;//button间距
@property (nonatomic,assign) float time;//动画完成时间
@property (nonatomic) enum ExpansionDirection direction;//展开方向

- (instancetype)initWithFrame:(CGRect)frame withDirection:(ExpansionDirection)direction;

// Public Methods
- (void)addButtons:(NSArray *)buttons;
- (void)addButton:(UIButton *)button;
- (void)showButtons;
- (void)dismissButtons;

@end

NS_ASSUME_NONNULL_END
