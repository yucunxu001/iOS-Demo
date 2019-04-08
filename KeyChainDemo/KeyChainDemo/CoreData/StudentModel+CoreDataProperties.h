//
//  StudentModel+CoreDataProperties.h
//  KeyChainDemo
//
//  Created by mkrq-yh on 2019/4/8.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//
//

#import "StudentModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface StudentModel (CoreDataProperties)

+ (NSFetchRequest<StudentModel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *sex;
@property (nonatomic) float grade;

@end

NS_ASSUME_NONNULL_END
