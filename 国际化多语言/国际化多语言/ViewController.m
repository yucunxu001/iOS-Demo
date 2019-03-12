//
//  ViewController.m
//  国际化多语言
//
//  Created by mkrq-yh on 2019/3/11.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    UILabel *label;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 200, self.view.frame.size.width, 50);
    btn.backgroundColor = [UIColor greenColor];
    btn.tag = 1;
    [btn setTitle:@"中文" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 300, self.view.frame.size.width, 50);
    btn1.tag = 2;
    btn1.backgroundColor = [UIColor greenColor];
    [btn1 setTitle:@"english" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn1.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(0, 400, self.view.frame.size.width, 50);
    btn2.tag = 3;
    btn2.backgroundColor = [UIColor greenColor];
    [btn2 setTitle:@"繁体" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn2.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    [self initPage];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(languageChange:) name:@"AppLanguageDidChangeNotification" object:nil];
}

- (void)initPage {
    
    [label removeFromSuperview];
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 500, self.view.frame.size.width, 100)];
    label.text = [self localeStringWithKey:@"Login"];
    [self.view addSubview:label];
}

//切换语言通知
- (void)languageChange:(id)sender {
    if (self.isViewLoaded && !self.view.window) {
        //这里置为nil，当视图再次显示的时候会重新走viewDidLoad方法
        self.view = nil;

    }
    [self initPage];

    
}

- (void)btnClick:(UIButton *)sender {
    NSLog(@"btnClick");
    switch (sender.tag) {
        case 1: { //中文
            [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hans" forKey:@"appLanguage"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        } break;
        case 2: { //english
            [[NSUserDefaults standardUserDefaults] setObject:@"en" forKey:@"appLanguage"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        } break;
        case 3: { //繁体
            [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hant" forKey:@"appLanguage"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }  break;
        default:
            break;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AppLanguageDidChangeNotification" object:nil];
    /*
     动态刷新所有页面
     替换完了宏定义，下面就是全局刷新界面了。实现方式上来说，我目前共想出了3种，实现方式上来说各有优劣。
     
     1.重新载入rootViewController
     这个方法应该是编码成本最低的方法了，只需要把原有的rootViewController移除并清空，然后重新设置一遍rootViewController就行了。但是这种实现方式会重新加载已经原来已经加载好的所有界面。
     
     2.语言改变发送通知
     在用户切换语言的时候，发送一个通知，然后在各个界面接收通知，更新所有需要更新的文本即可。这种方法适合新建的项目，在代码编写之初就预留好更新文本的方法，收到通知后调用此方法就行。如果已经是一个已上线项目，则改动成本比较高，需要改动的地方比较多。
     
     3. .h暴露一个更新文字的方法
     在用户切换语言的时候，遍历所有已经加载的界面，调用更新文字的方法。这种实现也是比较适合新建的项目，在代码编写之初就预留好更新文本的方法。如果项目已上线，则改动成本较高。
     */
}

//修改bundle
- (NSString*)localeStringWithKey:(NSString*)key{
    // Get the language code.
    NSString *languageCode = [[NSUserDefaults standardUserDefaults] objectForKey:@"appLanguage"];
    // Get the relevant language bundle.
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:languageCode ofType:@"lproj"];
    NSBundle *languageBundle = [NSBundle bundleWithPath:bundlePath];
    // Get the translated string using the language bundle.
    NSString *translatedString = [languageBundle localizedStringForKey:key value:@"" table:nil];
    
    if (translatedString.length < 1) {
        
        // There is no localizable strings file for the selected language.
        translatedString = NSLocalizedStringWithDefaultValue(key, nil, [NSBundle mainBundle], key, key);
    }
    
    return translatedString;
}



@end
