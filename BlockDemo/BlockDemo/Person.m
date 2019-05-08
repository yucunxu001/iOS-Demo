//
//  Person.m
//  BlockDemo
//
//  Created by mkrq-yh on 2019/4/30.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "Person.h"

@implementation Person


//使用block做参数
- (void)eatFoos:(Success)success {
    success(@"牛肉");
}

//返回block无参无返回值
- (void(^)(void))look {
    return ^() {
        NSLog(@"你看到了什么？");
    };
}

//返回block有参无返回值
- (void(^)(NSString *name))play {
    return ^(NSString *name) {
        NSLog(@"玩%@",name);
    };
}

//返回block有参有返回值
- (Person *(^)(int))sleep {
    return ^(int n) {
        NSLog(@"他睡了%d年",n);
        return self;
    };
}

@end
