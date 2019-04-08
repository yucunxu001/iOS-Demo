//
//  ViewController.m
//  KeyChainDemo
//
//  Created by mkrq-yh on 2019/4/4.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "ViewController.h"
#import "SAMKeychain.h"
#import "KeyChain.h"
#import "NSUserDefaults+Category.h"
#import "MusicDefaults.h"
#import "CoreData/CoreDataManager.h"
#import "CoreData/StudentModel+CoreDataClass.h"
#import "CoreData/StudentModel+CoreDataProperties.h"
#import "CoreData/TeacherModel+CoreDataClass.h"
#import "CoreData/TeacherModel+CoreDataProperties.h"
#import "SQLite/SQLiteDBManager.h"
#import "SQLite/Person.h"
#import "FMDBManager.h"

@interface ViewController ()

@end

NSString * const KEY_USERNAME_PASSWORD = @"com.company.app.usernamepassword";
NSString * const KEY_USERNAME = @"com.company.app.username";
NSString * const KEY_PASSWORD = @"com.company.app.password";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, self.view.frame.size.width-40, 50)];
    label.text = @"Keychain的使用";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:label];
    
    //使用 SAMKeychain
//    [self userSAMKeychain];
    //自定义 KeyChain 归档和解归档
//    [self userKeyChain];
    //属性列表(plist存储)
//    [self userPlist];
    //偏好设置(NSUserDefaults)
//    [self userNSUserDefaults];
    //使用沙盒
//    [self userSandBox];
    //使用CoreData
//    [self userCoreData];
    //使用SQlite
//    [self userSQlite];
    //使用FMDB
//    [self userFMDB];
    //使用Realm
    [self userRealm];

    
}

#pragma mark - 使用 SAMKeychain
- (void)userSAMKeychain {
    NSError *error = nil;
    SAMKeychainQuery *query = [[SAMKeychainQuery alloc] init];
    query.service = @"mkrq.demo.server";
    query.account = @"mkrq.demo.user";
    [query fetch:&error];
    
    if ([error code] == errSecItemNotFound) {
        NSLog(@"Password not found");
    } else if (error != nil) {
        NSLog(@"Some other error occurred: %@", [error localizedDescription]);
    }
    
    [SAMKeychain setPassword:@"123456789" forService:@"mkrq.demo.server" account:@"mkrq.demo.user"];
    NSString *pwd = [SAMKeychain passwordForService:@"mkrq.demo.server" account:@"mkrq.demo.user"];
    NSLog(@"pwd==%@",pwd);
}


#pragma mark - 使用 自定义 KeyChain
- (void)userKeyChain {
    //KeyChain存储数据
    NSMutableDictionary *userPairs = [NSMutableDictionary dictionary];
    [userPairs setObject:@"yucunxu" forKey:KEY_USERNAME];
    [userPairs setObject:@"123456" forKey:KEY_PASSWORD];
    NSLog(@"%@", userPairs); //有KV值
    // A、将用户名和密码写入keychain
    [KeyChain save:KEY_USERNAME_PASSWORD data:userPairs];
    
    // B、从keychain中读取用户名和密码
    NSMutableDictionary *readUsernamePassword = (NSMutableDictionary *)[KeyChain load:KEY_USERNAME_PASSWORD];
    NSString *userName = [readUsernamePassword objectForKey:KEY_USERNAME];
    NSString *password = [readUsernamePassword objectForKey:KEY_PASSWORD];
    NSLog(@"username = %@", userName);
    NSLog(@"password = %@", password);
    
    //C、删除存储的数据
    [KeyChain delete:KEY_USERNAME_PASSWORD];
}

#pragma mark - 使用 属性列表(plist存储)
- (void)userPlist {
    
    //获取plist文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSLog(@"获取到的plist数据==%@",dict);
}

#pragma mark - 使用 偏好设置(NSUserDefaults)
- (void)userNSUserDefaults {
    //保存
    [NSUserDefaults saveData:@"188666888" withKey:@"com.xiaotunshu.phone"];
    //获取
    NSString *phone = [NSUserDefaults getSaveData:@"com.xiaotunshu.phone"];
    NSLog(@"phone==%@",phone);
    //删除
    [NSUserDefaults removeSaveDataWithKey:@"com.xiaotunshu.phone"];
}

#pragma mark - 使用沙盒
- (void)userSandBox {
     [MusicDefaults toolToSaveMusicToCache:@"" withMusicName:@"耳朵"];
}

#pragma mark - 使用CoreData
- (void)userCoreData {
    
    //插入数据
    StudentModel *student = (StudentModel *)[CoreDataManager getTableWithEntityName:NSStringFromClass([StudentModel class])];
    student.name = @"CCC";
    student.sex = @"男";
    student.grade = 99.9;
    [CoreDataManager save];
    
    //查询数据
    NSArray *array = [CoreDataManager selectByEntityName:NSStringFromClass([StudentModel class]) withMaching:nil withAttribute:nil sortingBy:nil isAscending:NO];
    NSLog(@"array.count==%ld",array.count);
    for (NSInteger i = 0; i < array.count; i++) {
        StudentModel *student = array[i];
        NSLog(@"name==%@",student.name);
        NSLog(@"sex==%@",student.sex);
        NSLog(@"grade==%f",student.grade);
    }
    
    //删除数据
    [CoreDataManager deleteByEntityName:NSStringFromClass([StudentModel class]) withMaching:@"XXX" withAttribute:@"name"];
    [CoreDataManager deleteAllByEntityName:NSStringFromClass([StudentModel class])];
    
    //修改数据
    NSArray *array2 = [CoreDataManager selectByEntityName:NSStringFromClass([StudentModel class]) withMaching:@"AAA" withAttribute:@"name" sortingBy:nil isAscending:YES];
    NSLog(@"array2.count==%ld",array2.count);
    for (NSInteger i = 0; i < array2.count; i++) {
        StudentModel *student = array2[i];
        NSLog(@"name==%@",student.name);
        NSLog(@"sex==%@",student.sex);
        NSLog(@"grade==%f",student.grade);
        NSString *name = [NSString stringWithFormat:@"%@",student.name];
        if ([name isEqualToString:@"AAA"]) {
            student.grade = 99.9;
            [CoreDataManager updateManagedObject:student];

        }
    }
    
}

#pragma mark - 使用SQlite
- (void)userSQlite {
    
//    //添加数据
//    NSString *sqlStr = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(name CHAR(20) NOT NULL, sex CHAR(20) NOT NULL, phone CHAR(20) NOT NULL)",NSStringFromClass([Person class])];
//    [SQLiteDBManager createTableWithSql:sqlStr];
//    NSString *insetSql = [NSString stringWithFormat:@"INSERT INTO %@ (name, sex, phone) VALUES ('AAA', '男', '18866668888')", NSStringFromClass([Person class])];
//    [SQLiteDBManager operationRecordWithSql:insetSql];

    
//    //删除数据
//    NSString *deleteSql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE name = 'AAA'", NSStringFromClass([Person class])];
//    [SQLiteDBManager operationRecordWithSql:deleteSql];
//
//    //修改数据
//    NSString *updateSql = [NSString stringWithFormat:@"UPDATE %@ SET PHONE = '123456' WHERE name = 'AAA'", NSStringFromClass([Person class])];
//    [SQLiteDBManager operationRecordWithSql:updateSql];

    //查询数据
    NSString *selectSql = [NSString stringWithFormat:@"SELECT * FROM %@", NSStringFromClass([Person class])];
    NSArray *array = [SQLiteDBManager selectRecordWithSql:selectSql];
    for (NSInteger i = 0; i < array.count; i++) {
        NSDictionary *dict = array[i];
        NSLog(@"name==%@",dict[@"name"]);
        NSLog(@"sex==%@",dict[@"sex"]);
        NSLog(@"phone==%@",dict[@"phone"]);
    }
}

#pragma mark - 使用FMDB
- (void)userFMDB {
//    //创建表
//    NSString *creatStr =[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(name CHAR(20) NOT NULL, sex CHAR(20) NOT NULL, phone CHAR(20) NOT NULL)", NSStringFromClass([Person class])];
//    [FMDBManager executeAsynWithSql:creatStr isSuccess:^(BOOL isSuccess) {
//        if (isSuccess) {
//            NSLog(@"创建表成功");
//        }
//    }];

//    //插入数据
//    NSString *insertStr = [NSString stringWithFormat:@"INSERT INTO %@ (name, sex, phone) VALUES ('DDD', '男', '18866668888')", NSStringFromClass([Person class])];
//    [FMDBManager executeAsynWithSql:insertStr isSuccess:^(BOOL isSuccess) {
//        if (isSuccess) {
//            NSLog(@"插入数据成功");
//        }
//    }];
//
//    //删除数据
//    NSString *deleteStr = [NSString stringWithFormat:@"DELETE FROM %@ WHERE name = 'DDD'", NSStringFromClass([Person class])];
//    [FMDBManager executeAsynWithSql:deleteStr isSuccess:^(BOOL isSuccess) {
//        if (isSuccess) {
//            NSLog(@"删除数据成功");
//        }
//    }];
//
//    //修改数据
//    NSString *modifyStr = [NSString stringWithFormat:@"UPDATE %@ SET PHONE = '123456' WHERE name = 'DDD'", NSStringFromClass([Person class])];
//    [FMDBManager executeAsynWithSql:modifyStr isSuccess:^(BOOL isSuccess) {
//        if (isSuccess) {
//            NSLog(@"修改数据成功");
//        }
//    }];
    
    //查询数据
    NSString *selectSql = [NSString stringWithFormat:@"SELECT * FROM %@", NSStringFromClass([Person class])];
    [FMDBManager executeAsynQueryWithSql:selectSql isSuccess:^(NSArray * _Nonnull resultArray) {
        for (NSInteger i = 0; i < resultArray.count; i++) {
            NSDictionary *dict = resultArray[i];
            NSLog(@"name==%@",dict[@"name"]);
            NSLog(@"sex==%@",dict[@"sex"]);
            NSLog(@"phone==%@",dict[@"phone"]);
        }
    }];
}

#pragma mark - 使用Realm
- (void)userRealm {
    
}

@end
