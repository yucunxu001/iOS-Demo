//
//  TeacherModel+CoreDataProperties.h
//  KeyChainDemo
//
//  Created by mkrq-yh on 2019/4/8.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//
//

#import "TeacherModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface TeacherModel (CoreDataProperties)

+ (NSFetchRequest<TeacherModel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int32_t age;
@property (nullable, nonatomic, copy) NSString *sex;

@end

NS_ASSUME_NONNULL_END
