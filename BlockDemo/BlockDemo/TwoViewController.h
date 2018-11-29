//
//  TwoViewController.h
//  BlockDemo
//
//  Created by mkrq-yh on 2018/11/29.
//  Copyright © 2018 mkrq-yh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ChangeMsg)(NSString *msg);

@interface TwoViewController : UIViewController

@property (nonatomic,copy) ChangeMsg changeMsg;

@end

NS_ASSUME_NONNULL_END
