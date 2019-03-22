//
//  AnimalFactory.m
//  OCDemo
//
//  Created by mkrq-yh on 2019/3/21.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "AnimalFactory.h"
#import "Animal.h"
#import "Dog.h"
#import "Cat.h"

NSString *DogClassName = @"Dog";
NSString *CatClassName = @"Cat";

@implementation AnimalFactory

- (void)createObject:(NSString *)className complete:(void(^)(Animal *obj))callBack {
    if ([className isEqualToString:NSStringFromClass([Dog class])]) {
        //创建对象
        Dog *dog = [[Dog alloc] init];
        //回调
        callBack(dog);
        //狗叫
        [dog dogCall];
    }
    
    if ([className isEqualToString:NSStringFromClass([Cat class])]) {
        //创建对象
        Cat *cat = [[Cat alloc] init];
        //回调
        callBack(cat);
        //抓老鼠
        [cat catchTheMouse];
    }
}

@end
