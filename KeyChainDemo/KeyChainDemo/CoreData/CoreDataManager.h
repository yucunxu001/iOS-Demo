//
//  CoreDataManager.h
//  KeyChainDemo
//
//  Created by mkrq-yh on 2019/4/8.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoreDataManager : NSObject

//数据模型
@property (nonatomic, strong) NSManagedObjectModel *objectModel;
//持久化数据
@property (nonatomic, strong) NSPersistentStoreCoordinator *coordinator;
//管理数据的对象
@property (nonatomic, strong) NSManagedObjectContext *objectContext;

/**
 单利创建
 @return CoreDataManager
 */
+ (instancetype)sharedInstanceManager;

//- (BOOL)insertData:(NSDictionary*)info;
//- (BOOL)deleteItemByName:(NSString*)name;

/**
 删除数据库
 */
+ (void)managerForDelete;

/**
 获取数据模型
 @param entityName 数据模型类名称
 @return return value description
 */
+ (NSManagedObject *)getTableWithEntityName:(NSString * _Nonnull)entityName;

/**
 保存数据
 */
+ (BOOL)save;


/**
 删除数据
 @param entityName   数据模型类名称
 @param searchString 属性名的值包含的字符
 @param attribute    属性名称
 @return             成功失败
 */
+ (BOOL)deleteByEntityName:(NSString * _Nonnull)entityName
               withMaching:(NSString * _Nonnull)searchString
             withAttribute:(NSString * _Nonnull)attribute;

/**
 删除某个模型的所有数据
 @param entityName   数据模型类名称
 */
+ (BOOL)deleteAllByEntityName:(NSString * _Nonnull)entityName;

/**
 更新数据
 @param managedObject pojo对象
 @return bool
 */
+ (BOOL)updateManagedObject:(NSManagedObject *)managedObject;

/**
 查询数据
 @param entityName   数据模型类名称
 @param searchString 属性名的值包含的字符
 @param attribute    属性名称
 @param sortArribute 按哪个属性名称排序
 @param ascending    是否升序
 @return             模型数组
 */
+ (NSArray *)selectByEntityName:(NSString * _Nonnull)entityName
                    withMaching:(NSString * _Nullable)searchString
                  withAttribute:(NSString * _Nullable)attribute
                      sortingBy:(NSString * _Nullable)sortArribute
                    isAscending:(BOOL)ascending;



@end

NS_ASSUME_NONNULL_END
