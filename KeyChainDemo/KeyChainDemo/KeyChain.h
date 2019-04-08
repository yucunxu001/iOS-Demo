//
//  KeyChain.h
//  KeyChainDemo
//
//  Created by mkrq-yh on 2019/4/8.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

NS_ASSUME_NONNULL_BEGIN

@interface KeyChain : NSObject

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service;

// save username and password to keychain
+ (void)save:(NSString *)service data:(id)data;

// load username and password from keychain
+ (id)load:(NSString *)service;

// delete username and password from keychain
+ (void)delete:(NSString *)serviece;

@end

NS_ASSUME_NONNULL_END
