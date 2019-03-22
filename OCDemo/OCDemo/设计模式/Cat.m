//
//  Cat.m
//  OCDemo
//
//  Created by mkrq-yh on 2019/3/21.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "Cat.h"

@implementation Cat

- (void)printClassName {
    NSLog(@"%@---%@",NSStringFromClass([self class]),self);
}

- (void)catchTheMouse {
    NSLog(@"抓老鼠");
}

@end
