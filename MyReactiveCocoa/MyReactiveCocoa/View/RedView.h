//
//  RedView.h
//  MyReactiveCocoa
//
//  Created by mkrq-yh on 2019/4/9.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface RedView : UIView

@property (nonatomic,strong) RACSubject *btnClickSignal;

- (instancetype)initWithFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
