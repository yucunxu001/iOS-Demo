//
//  AnimationDelegate.m
//  CoreAnimationDemo
//
//  Created by mkrq-yh on 2019/4/23.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "AnimationDelegate.h"

@implementation AnimationDelegate

- (void)animationDidStart:(CAAnimation *)anim
{
    NSLog(@"Animation Start");
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"Animation Stop");
}

- (void)dealloc
{
    NSLog(@"Delegate Dealloc");
}

@end
