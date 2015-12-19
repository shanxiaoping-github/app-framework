//
//  NSString+Utils.h
//  Common
//
//  Created by calvin on 14-4-2.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utils)

- (NSString*)encodeAsURIComponent;
- (NSString*)escapeHTML;
- (NSString*)unescapeHTML;

+ (NSString*)localizedString:(NSString*)key;

+ (NSString*)base64encode:(NSString*)str;


+ (NSString *)dateWithTimeInterval:(NSTimeInterval)timeInterval formatter:(NSString *)formatter;
+ (NSString *)dateWithDate:(NSDate *)date formatter:(NSString *)formatter;

- (NSString *)flattenHTMLWithImgStyle;
- (NSString *)flattenHTMLWhiteSpace:(BOOL)trim;
- (NSString *)stringByDecodingHTMLEntitiesInString;
- (NSString *)stringByStrippingHTML;
- (NSString *)stringByStrippingSpace;
- (NSString *)flattenImgHTMLWithWihtString:(NSString *)str;

+ (NSString*)encodeBase64String:(NSString *)input;
+ (NSString*)decodeBase64String:(NSString *)input;
+ (NSString*)encodeBase64Data:(NSData *)data;
+ (NSString*)decodeBase64Data:(NSData *)data;

+ (NSString*)guid;
/**
 * 编写正编写正则表达式：最多输入50个中文、英文、数字的字符，且不能包含英文标点和特殊符号
 *
 * @return no 合法， yes 非法
*/
+ (BOOL)isLegalInputString:(NSString*)inputString;

/**
 * 检测是否为空字符串,如果为空,则返回yes
 */
+(BOOL) isBlankString:(NSString *)string;

@end
