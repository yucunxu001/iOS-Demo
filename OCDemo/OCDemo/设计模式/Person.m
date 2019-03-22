//
//  Person.m
//  OCDemo
//
//  Created by mkrq-yh on 2019/3/20.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "Person.h"

@implementation Person

//第一种就是直接赋值
- (void)changeName:(NSString *)name {
    _name = name;
}

//第二种点语法赋值
- (void)changeNameFromSetter:(NSString *)name {
    self.name = name;
}

@end
