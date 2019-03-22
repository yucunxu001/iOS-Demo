//
//  AnimalFactory.h
//  OCDemo
//
//  Created by mkrq-yh on 2019/3/21.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Animal.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString *DogClassName;
extern NSString *CatClassName;
//@class Animal;

@interface AnimalFactory : NSObject

- (void)createObject:(NSString *)className complete:(void(^)(Animal *obj))callBack;

@end

NS_ASSUME_NONNULL_END
