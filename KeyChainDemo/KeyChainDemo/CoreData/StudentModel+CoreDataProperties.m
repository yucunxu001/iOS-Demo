//
//  StudentModel+CoreDataProperties.m
//  KeyChainDemo
//
//  Created by mkrq-yh on 2019/4/8.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//
//

#import "StudentModel+CoreDataProperties.h"

@implementation StudentModel (CoreDataProperties)

+ (NSFetchRequest<StudentModel *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"StudentModel"];
}

@dynamic name;
@dynamic sex;
@dynamic grade;

@end
