//
//  Dog.m
//  OCDemo
//
//  Created by mkrq-yh on 2019/3/21.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "Dog.h"

@implementation Dog

- (void)printClassName {
    NSLog(@"%@---%@",NSStringFromClass([self class]),self);
}

- (void)dogCall {
    NSLog(@"汪汪汪！");
}

@end
