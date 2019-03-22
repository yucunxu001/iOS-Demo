//
//  CustomView.h
//  OCDemo
//
//  Created by mkrq-yh on 2019/3/20.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CustomViewDelegate <NSObject>

//选中
- (void)selectedItemButton:(NSInteger)index;

@end

@interface CustomView : UIView

- (instancetype)initWithFrame:(CGRect)frame withVC:(UIViewController *)vc;

@property (nonatomic,strong) UIView *bgView;

@property (nonatomic,weak) id<CustomViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
