//
//  StringUtil.h
//  WMF
//
//  Created by 单小萍 on 15/6/16.
//  Copyright (c) 2015年 beijingwomaifang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface StringUtil : NSObject
/*判断字符串是否为空*/
+(BOOL)isEmpty:(NSString*)str;
/*判断json字符串是否为空*/
+(BOOL)isJsonEmpty:(NSString*)str;
/*字符串拆分*/
+(NSMutableArray*)sqlite:(NSString*)str symbol:(NSString*)symbol excluding:(NSString*)excluding;
+(NSMutableArray*)sqlite:(NSString*)str symbol:(NSString*)symbol;
/*自定义替换*/
+(NSString*)customReplaceString:(NSString*)str replaceStr:(NSString*)replaceStr start:(int)startIndex end:(int)endIndex;
/*是否是数字*/
+(BOOL)isAllNumberOfString:(NSString *)myString;
/*替换字符串*/
+(NSString*)replaceStrSource:(NSString*)sourceStr requestReplaceStr:(NSString*)requestReplaceStr replaceStr:(NSString*)replaceStr ;
/*替换公司信息*/
+(NSString*)replaceCompanyInformation:(NSString*)souceStr;
/*获取唯一标识*/
+(NSString*)getUUID;
/*获取分段颜色文字*/
+(NSMutableAttributedString*)getAttributeString:(NSString*)content colors:(NSArray*)colors indexs:(NSArray*)indexs;
/*计算字符串高度*/
+(CGFloat)getStringHeight:(NSString*)content font:(UIFont*)font size:(CGSize)size;
/*计算字符串宽度*/
+(CGFloat)getStringWidth:(NSString*)content font:(UIFont*)font size:(CGSize)size;

@end
