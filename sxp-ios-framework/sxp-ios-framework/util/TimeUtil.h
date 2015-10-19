//
//  TimeUtil.h
//  mqsystem
//
//  Created by shanxiaoping on 15-3-2.
//  Copyright (c) 2015年 yicai. All rights reserved.
//
/*时间处理*/
#import <Foundation/Foundation.h>
#define DATA1 @"yyyy-MM-dd HH:mm:ss"
#define DATA2 @"yyyy年MM月dd日 HH:mm:ss"
#define DATA3 @"yyyy年MM月dd日"
#define DATA4 @"yyyy-MM-dd"

@interface TimeUtil : NSObject
/*时间转为字符串形式*/
+(NSString*)nsDataToString:(NSDate*)data format:(NSString*)formatString;
/*字符串转为日期*/
+(NSDate*)stringToNsData:(NSString*)dataString format:(NSString*)formatString;
/*判断两个日期的大小 */
+(NSInteger)compareData:(NSDate*)data1 toData:(NSDate*)data2;
/*数字转化为时间*/
+(NSString*)numberToString:(id)time format:(NSString*)formatString;
/*获取时间*/
+(NSString*)getTimeDayHourSecond:(NSDate*)date formatString:(NSString*)formatStr;
/*获得天*/
+(NSString*)getDay:(NSDate*)date;
/*获得小时*/
+(NSString*)getHours:(NSDate*)date;
/*获得分*/
+(NSString*)getMinute:(NSDate*)date;
/*获得秒*/
+(NSString*)getSeconde:(NSDate*)date;
/*获得当前时间*/
+(NSString*)nowTime:(NSString*)formatString;
@end
