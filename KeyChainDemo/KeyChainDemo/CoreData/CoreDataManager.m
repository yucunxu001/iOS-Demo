//
//  CoreDataManager.m
//  KeyChainDemo
//
//  Created by mkrq-yh on 2019/4/8.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "CoreDataManager.h"

#define HJStrIsEmpty(str) ((str == nil) || ([str isEqualToString: @""]) || (str == NULL) ||     ([str isKindOfClass:[NSNull class]]))

@implementation CoreDataManager

#pragma mark - 单利创建
+ (instancetype)sharedInstanceManager {
    static CoreDataManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CoreDataManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    if (self = [super init]) {
        //创建托管对象模型
//        NSURL *url = [[NSBundle mainBundle] URLForResource:@"MyCoreData" withExtension:@"momd"];
//        _objectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:url];
//        //创建持久化数据协调器
//        _coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_objectModel];
//        //关联并创建本地数据库文件
//        [_coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[self dbPath] options:nil error:nil];
//        //创建托管对象上下文
//        _objectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:(NSMainQueueConcurrencyType)];
//        [_objectContext setPersistentStoreCoordinator:_coordinator];
        
        [self managedObjectModelInitialization];
        [self persistentStoreCoordinatorInitialization];
        [self contextInitialization];
    }
    return self;
}

/*
 * 函数名: managedObjectModelInitialization
 * 参数: 无
 * 返回类型 : NSManagedObjectModel
 * 作用: 初始化数据模型
 */
- (NSManagedObjectModel *)managedObjectModelInitialization {
    //检查 NSManagedObjectModel 是否已经存在
    if (!_objectModel) {
        //如果不存在 采用CoreDataDemo 的模型，这个模型的bundle 就是Demo_CoreData
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Demo" withExtension:@"momd"];
        _objectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    }
    return _objectModel;
}
/*
 * 函数名 : persistentCoordinatorInitialization
 * 参数 : null
 * 返回类型 : NSPersistentStoreCoordinator
 * 作用: 初始化协调器
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinatorInitialization {
    if (!_coordinator) {
        //采用_managedObjectModel 的数据模型 初始化协调器
        _coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_objectModel];
        // 用来获取 document 目录
        NSString *docStr = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        //增加一个CoreDataDemo.sqlite 数据库
        NSString *sqlPath = [docStr stringByAppendingPathComponent:@"CoreDataDemo.sqlite"];
        // 指定本地的 sqlite 数据库文件
        NSURL *sqlUrl = [NSURL fileURLWithPath:sqlPath];
        NSError *error = nil;
        // 为 persistentStoreCoordinator 指定本地存储的类型，这里指定的是 SQLite
        [_coordinator addPersistentStoreWithType:NSSQLiteStoreType
                                           configuration:nil
                                                     URL:sqlUrl
                                                 options:nil
                                                   error:&error];
        if (error) {
            NSLog(@"增加数据库失败:%@",error);
        } else {
            NSLog(@"增加数据库成功");
        }
    }
    return _coordinator;
}
/*
 * 函数名 : contextInitialization
 * 参数 : 无
 * 返回类型 : NSManagedObjectContext
 * 作用: 初始化上下文
 */
- (NSManagedObjectContext *)contextInitialization {
    if (!_objectContext) {
        // 指定 context 的并发类型： NSMainQueueConcurrencyType 或 NSPrivateQueueConcurrencyType
        _objectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        _objectContext.persistentStoreCoordinator = _coordinator; //关联存储持久化协调器
    }
    return _objectContext;
}

/**
 获取数据库路径
 @return return value description
 */
- (NSURL *)dbPath {
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *dbFolder = [documentPath stringByAppendingPathComponent:@"Demo"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:dbFolder]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:dbFolder withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSURL *dbUrl = [[NSURL fileURLWithPath:dbFolder] URLByAppendingPathComponent:@"db.sqlite"];
    return dbUrl;
}

#pragma mark - 删除数据库
+ (void)managerForDelete {
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"Demo"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    }
}


#pragma mark - 获取数据模型
+ (NSManagedObject *)getTableWithEntityName:(NSString *)entityName {
    NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:[CoreDataManager sharedInstanceManager].objectContext];
    return managedObject;
}

#pragma mark - 保存数据
+ (BOOL)save {
    NSError *error;
    BOOL success = [[CoreDataManager sharedInstanceManager].objectContext save:&error];
    return success;
}

#pragma mark - 删除数据
+ (BOOL)deleteByEntityName:(NSString * _Nonnull)entityName
               withMaching:(NSString * _Nonnull)searchString
             withAttribute:(NSString * _Nonnull)attribute {
    //没有输入删除条件
    if (HJStrIsEmpty(attribute) || HJStrIsEmpty(searchString)) {
        return YES;
    }
    //查询数据
    NSArray *array = [self selectByEntityName:entityName
                                  withMaching:searchString
                                withAttribute:attribute
                                    sortingBy:attribute
                                  isAscending:YES];
    if (array.count > 0) {
        //删除
        for (NSManagedObject *object in array) {
            [[CoreDataManager sharedInstanceManager].objectContext deleteObject:object];
        }
    }
    //执行保存操作
    return [CoreDataManager save];
}

/**
 删除某个模型的所有数据
 @param entityName   数据模型类名称
 */
+ (BOOL)deleteAllByEntityName:(NSString * _Nonnull)entityName {
    //查询数据
    NSArray *array = [self selectByEntityName:entityName
                                  withMaching:nil
                                withAttribute:nil
                                    sortingBy:nil
                                  isAscending:YES];
    if (array.count > 0) {
        //删除
        for (NSManagedObject *object in array) {
            [[CoreDataManager sharedInstanceManager].objectContext deleteObject:object];
        }
    }
    //执行保存操作
    return [CoreDataManager save];
}

#pragma mark - 更新数据
+ (BOOL)updateManagedObject:(NSManagedObject *)managedObject {
    [[CoreDataManager sharedInstanceManager].objectContext refreshObject:managedObject mergeChanges:YES];
    return [CoreDataManager save];
}

#pragma mark - 查询数据
+ (NSArray *)selectByEntityName:(NSString * _Nonnull)entityName
                    withMaching:(NSString * _Nullable)searchString
                  withAttribute:(NSString * _Nullable)attribute
                      sortingBy:(NSString * _Nullable)sortArribute
                    isAscending:(BOOL)ascending{
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:[CoreDataManager sharedInstanceManager].objectContext];
    //创建fetch请求
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = entity;
    //一次性获取完
    [fetchRequest setFetchBatchSize:0];
    if (!HJStrIsEmpty(sortArribute)) {
        //排序
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortArribute ascending:ascending selector:nil];
        NSArray *descriptors = @[sortDescriptor];
        fetchRequest.sortDescriptors = descriptors;
    } else {
        fetchRequest.sortDescriptors = @[];
    }

    if (!HJStrIsEmpty(searchString) && !HJStrIsEmpty(attribute)) {
        //某个属性的值包含某个字符串
        //%K 某个属性的值
        //%@ 传递过来的字符串
        //模糊查询 contains[cd] 包含某个值 c标识忽略大小写，d标识忽略重音
        //查询 ==
        fetchRequest.predicate = [NSPredicate predicateWithFormat:@"%K == %@",attribute, searchString];
    }
    NSError *error;
    NSFetchedResultsController *fetchedController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[CoreDataManager sharedInstanceManager].objectContext sectionNameKeyPath:nil cacheName:nil];
    //执行获取操作
    if ([fetchedController performFetch:&error]) {
        //获取数据
        return [fetchedController fetchedObjects];
    } else {
        return @[];
    }
}

@end
