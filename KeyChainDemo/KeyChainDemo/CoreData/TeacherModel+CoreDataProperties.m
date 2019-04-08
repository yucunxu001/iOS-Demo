//
//  TeacherModel+CoreDataProperties.m
//  KeyChainDemo
//
//  Created by mkrq-yh on 2019/4/8.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//
//

#import "TeacherModel+CoreDataProperties.h"

@implementation TeacherModel (CoreDataProperties)

+ (NSFetchRequest<TeacherModel *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"TeacherModel"];
}

@dynamic name;
@dynamic age;
@dynamic sex;

@end
