//
//  Color.h
//  BaseUIDemo
//
//  Created by mkrq-yh on 2019/1/10.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#ifndef Color_h
#define Color_h

//RBG颜色 不透明
#define RGB(r,g,b)               [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
//RGBA颜色 透明度
#define RGBA(r,g,b,a)            [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
//
#define kColor(hexStr)            [Utils colorWithHexString:hexStr]

#define kBgColor            kColor(@"#f0f0f0")
#define kNavColor           kColor(@"#FFFFFF")//Nav主题颜色
#define kTitleColor         kColor(@"#666666")//标题颜色
#define kColor999           kColor(@"#999999")
#define kColorBlack         kColor(@"#000000")//黑色背景
#define kColorWhite         kColor(@"#FFFFFF")//白色背景
#define kColor333           kColor(@"#333333")//黑色字体
#define kColor666           kColor(@"#666666")//
#define kTabNormalColor     kColor(@"#777777")//
#define kTabSelectColor     kColor(@"#ff3259")//
#define kGreenColor         [UIColor greenColor]
#define kRedColor           [UIColor redColor]
#define kColorccc           kColor(@"#cccccc")//

#endif /* Color_h */
