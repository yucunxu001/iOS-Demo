//
//  Person.h
//  KeyChainDemo
//
//  Created by mkrq-yh on 2019/4/8.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *phone;

@end

NS_ASSUME_NONNULL_END
