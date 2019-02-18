//
//  ViewController.m
//  HTMLStringDemo
//
//  Created by mkrq-yh on 2019/1/25.
//  Copyright © 2019 mkrq-yh. All rights reserved.
//

#import "ViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "UIPasteboard+AttributedString.h"
#import "TFHpple.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    /*
    NSString *htmlString = @"<p class='p1'><span style='color: rgb(255, 0, 0); font-size: 24px;'>匹克童鞋</span></p><p class='p1'><span style='color: rgb(0, 176, 80);'>券后包邮秒杀</span></p><p class='p3'><br/></p>";
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    UILabel * myLabel = [[UILabel alloc] initWithFrame:self.view.bounds];
    myLabel.attributedText = attributedString;
    myLabel.numberOfLines = 0;
    [self.view addSubview:myLabel];
     */
    
//    //1.将字符串转化为标准HTML字符串
//    NSString *msgStr = [self htmlEntityDecode:htmlString];
//    //2.将HTML字符串转换为attributeString
//    NSAttributedString *attributedString = [self attributedStringWithHTMLString:msgStr];
    
    NSString *htmlString = @"<p class='p1'><span style='color: rgb(255, 0, 0); font-size: 24px;'>匹克童鞋</span></p><p class='p1'><span style='color: rgb(0, 176, 80);'>券后包邮秒杀</span></p><p class='p3'><br/></p>";
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    UILabel * myLabel = [[UILabel alloc] initWithFrame:self.view.bounds];
    myLabel.attributedText = attributedString;
    myLabel.numberOfLines = 0;
    [self.view addSubview:myLabel];

//    NSDictionary *dic = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSCharacterEncodingDocumentAttribute:@(NSUnicodeStringEncoding)};
//    NSData *data = [attributedString dataFromRange:NSMakeRange(0, attributedString.length) documentAttributes:dic error:nil];
//    NSString *str = [[NSString alloc] initWithData:data encoding:NSUnicodeStringEncoding];

    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setAttributedString:attributedString];
//    [pasteboard setString:str];
    
    NSLog(@"11111111111111111");
    


    
}



//将 &lt 等类似的字符转化为HTML中的“<”等
- (NSString *)htmlEntityDecode:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"]; // Do this last so that, e.g. @"&amp;lt;" goes to @"&lt;" not @"<"
    
    return string;
}




//将HTML字符串转化为NSAttributedString富文本字符串
- (NSAttributedString *)attributedStringWithHTMLString:(NSString *)htmlString
{
    NSDictionary *options = @{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
                               NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding) };
    
    NSData *data = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    
    return [[NSAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
}


@end
