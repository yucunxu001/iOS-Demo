//
//  macro.h
//  StoryboardDemo
//
//  Created by mkrq-yh on 2019/4/19.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#ifndef macro_h
#define macro_h

//尺寸宏
#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height

////需要横屏或者竖屏，获取屏幕宽度与高度
//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000 // 当前Xcode支持iOS8及以上
//
//#define SCREEN_WIDTH ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.width)
//#define SCREENH_HEIGHT ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.height)
//#define SCREEN_SIZE ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?CGSizeMake([UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale,[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale):[UIScreen mainScreen].bounds.size)
//#else
//#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
//#define SCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height
//#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
//#endif


#define StartBarHeight  [[UIApplication sharedApplication] statusBarFrame].size.height
#define NavHeight       self.navigationController.navigationBar.bounds.size.height
#define TabHeight       self.tabBarController.tabBar.bounds.size.height
#define BarHeight       (NavHeight+StartBarHeight)

// 适配 等比放大控件 750 稿子的宽度
#define px(x)           ((x)*1.0*kScreenWidth/750)

// RGB颜色转换（16进制->10进制）不透明
#define kColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
// RGB颜色转换（16进制->10进制）透明度
#define kColorA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]
// 随机颜色
#define RandomColor     [UIColor colorWithRed:(arc4random()%255)/255.0 green:(arc4random()%255)/255.0 blue:(arc4random()%255)/255.0 alpha:1.0]
//RBG颜色 不透明
#define RGB(r,g,b)      [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
//RGBA颜色 透明度
#define RGBA(r,g,b,a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

//获取图片
#define kGetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

//打印方法
#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)
#else
#define NSLog(...)
#define debugMethod()
#endif

// Directory 目录
#define PATH_DIRECTORY [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
// Cache 目录
#define PATH_CACHE [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
// 数据库 目录
#define PATH_DATABASE_CACHE [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define kWindow [UIApplication sharedApplication].keyWindow

//设备名称
#define kDeviceName                [[UIDevice currentDevice] systemName]
//手机系统版本
#define kSystemVersion             [[UIDevice currentDevice] systemVersion]
//手机型号
#define kPhoneModel                [[UIDevice currentDevice] model]
// 当前应用名称
#define kAppName                   [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
// 当前APP版本号  比如：1.0.1
#define kAppVersion                [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
// 当前APP版本号码  int类型 比如：10
#define kAppVersionInt             [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

#endif /* macro_h */
