//
//  RealmBaseModel.h
//  KeyChainDemo
//
//  Created by mkrq-yh on 2019/4/8.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "RLMObject.h"
#import <Realm/Realm.h>

NS_ASSUME_NONNULL_BEGIN

@interface RealmBaseModel : RLMObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, strong) NSString *address;

@end

RLM_ARRAY_TYPE(RealmBaseModel)

NS_ASSUME_NONNULL_END
