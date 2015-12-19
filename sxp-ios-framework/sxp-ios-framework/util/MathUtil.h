//
//  MathUtil.h
//  mqsystem
//
//  Created by shanxiaoping on 15-1-26.
//  Copyright (c) 2015年 yicai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MathUtil : NSObject
/*number转nstring*/
+(NSString*)numberToString:(NSNumber*)number;
/*string转number*/
+(NSNumber*)stringToNumber:(NSString*)str;
/*判断是否是数字*/
+(BOOL)isNumber:(NSString *)str lastNumber:(NSInteger)lastNumber;
//获取字典每个下标的对象
+(id)getObjectForNSDictionary:(NSDictionary*)dic index:(NSInteger)index;
//获取字典每个下标的key
+(NSString*)getKeyForNSDictionary:(NSDictionary*)dic index:(NSInteger)index;
//大数相乘
+(NSString*)decimalNumberMutiplyWithString:(NSString*)multiplierValue value2:(NSString*)multiplicandValue;
//大数相除
+(NSString*)decimalNumberDividingWithString:(NSString*)divtiplierValue value2:(NSString*)divtiplicandValue;
//大数相加
+(NSString*)decimalNumberAddWithString:(NSString*)addtiplierValue value2:(NSString*)addtiplicandValue;
//大数相减
+(NSString*)decimalNumberSubWithString:(NSString*)subtiplierValue value2:(NSString*)subtiplicandValue;
@end
