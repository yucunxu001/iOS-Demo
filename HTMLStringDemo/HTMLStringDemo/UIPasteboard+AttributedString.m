//
//  UIPasteboard+AttributedString.m
//  TestDemo
//
//  Created by mkrq-yh on 2018/12/5.
//  Copyright © 2018 mkrq-yh. All rights reserved.
//

#import "UIPasteboard+AttributedString.h"

@implementation UIPasteboard (AttributedString)

- (void)setAttributedString:(NSMutableAttributedString *)attributedString {
    NSData *rtf = [attributedString dataFromRange:NSMakeRange(0, attributedString.length) documentAttributes:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} error:nil];
    self.items = @[@{(id)kUTTypeRTF: [[NSString alloc] initWithData:rtf encoding:NSUTF8StringEncoding],(id)kUTTypeUTF8PlainText: attributedString.string}];
    
//    NSAttributedString * attributedString = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];

}

//- (void)setAttributedString:(NSAttributedString *)attributedString;
//{
//    //\ufffc为对象占位符，目的是当富文本中有图像时，只复制文本信息！！！
//    NSString *htmlString = [[attributedString string] stringByReplacingOccurrencesOfString:@"\ufffc" withString:@""];
//    NSMutableDictionary *item = [NSMutableDictionary dictionaryWithCapacity:1];
//    [item setValue:htmlString forKey:(NSString *)kUTTypeText];
//    self.items = [NSArray arrayWithObject:item];
//}

//- (void)setAttributedString:(NSMutableAttributedString *)attributedString
//{
//    NSData *rtf = [attributedString dataFromRange:NSMakeRange(0, attributedString.length) documentAttributes:@{NSDocumentTypeDocumentAttribute:NSRTFTextDocumentType} error:nil];
//    self.items = @[@{(id)kUTTypeRTF:[[NSString alloc] initWithData:rtf encoding:NSUTF8StringEncoding],(id)kUTTypeUTF8PlainText:attributedString.string}];
//}


@end
