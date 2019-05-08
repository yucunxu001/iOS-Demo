//
//  TwoViewController.h
//  BlockDemo
//
//  Created by mkrq-yh on 2018/11/29.
//  Copyright © 2018 mkrq-yh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ChangeName)(NSString *name);

@interface TwoViewController : UIViewController

@property (nonatomic,copy) ChangeName changeName;

@end

NS_ASSUME_NONNULL_END
