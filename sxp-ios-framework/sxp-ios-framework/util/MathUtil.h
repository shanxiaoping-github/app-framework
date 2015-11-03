//
//  MathUtil.h
//  mqsystem
//
//  Created by shanxiaoping on 15-1-26.
//  Copyright (c) 2015年 yicai. All rights reserved.
//
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
#import <Foundation/Foundation.h>
@interface MathUtil : NSObject
/*number转nstring*/
+(NSString*)numberToString:(NSNumber*)number;
/*string转number*/
+(NSNumber*)stringToNumber:(NSString*)str;
/*判断是否是数字*/
+(BOOL)isNumber:(NSString *)str;
//是否是数字
+(BOOL)isNumberforObject:(id)object;
//获取字典每个下标的对象
+(id)getObjectForNSDictionary:(NSDictionary*)dic index:(NSInteger)index;
//获取字典每个下标的key
+(NSString*)getKeyForNSDictionary:(NSDictionary*)dic index:(NSInteger)index;

@end
