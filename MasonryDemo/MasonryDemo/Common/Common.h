//
//  Common.h
//  MasonryDemo
//
//  Created by mkrq-yh on 2018/11/20.
//  Copyright © 2018年 mkrq-yh. All rights reserved.
//

#ifndef Common_h
#define Common_h

#define kScreenWidth        ([[UIScreen mainScreen] bounds].size.width)
#define kScreenHeight       ([[UIScreen mainScreen] bounds].size.height)

// 定义这个常量，就可以不用在开发过程中使用"mas_"前缀。
#define MAS_SHORTHAND
// 定义这个常量，就可以让Masonry帮我们自动把基础数据类型的数据，自动装箱为对象类型。
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"


#endif /* Common_h */
