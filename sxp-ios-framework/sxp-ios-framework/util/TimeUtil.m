//
//  TimeUtil.m
//  mqsystem
//
//  Created by shanxiaoping on 15-3-2.
//  Copyright (c) 2015年 yicai. All rights reserved.
//

#import "TimeUtil.h"

@implementation TimeUtil
+(NSString*)nsDataToString:(NSDate*)data format:(NSString *)formatString{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:formatString];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:data];
    return currentDateStr;
}


+(NSDate *)stringToNsData:(NSString *)dataString format:(NSString *)formatString{
    //实例化一个NSDateFormatter对象
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormat setDateFormat:formatString];
    
    NSDate *date =[dateFormat dateFromString:dataString];
    
    return date;

}
+(NSInteger)compareData:(NSDate *)data1 toData:(NSDate *)data2{
    if ([data1 isEqualToDate:data2]){
        return 0;
    }else if([data1 earlierDate:data2]==data1){
        return -1;
        
    }else{
        return 1;
    }
}
+(NSString*)numberToString:(id)time format:(NSString *)formatString{
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateStyle:NSDateFormatterLongStyle];
    [formatter setTimeStyle:NSDateFormatterLongStyle];
    [formatter setDateFormat:formatString];
    NSDate* confromTimesp = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[time longLongValue]];
    NSString* confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}

+(NSString*)getTimeDayHourSecond:(NSDate *)date formatString:(NSString*)formatStr{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:formatStr];
    NSString *time = [dateFormatter stringFromDate:date];
    return time;
}

+(NSString*)getDay:(NSDate*)date{
    return [TimeUtil getTimeDayHourSecond:date formatString:@"dd"];
}
+(NSString*)getHours:(NSDate *)date{
    return [TimeUtil getTimeDayHourSecond:date formatString:@"HH"];
}
+(NSString*)getMinute:(NSDate *)date{
    return [TimeUtil getTimeDayHourSecond:date formatString:@"mm"];
}
+(NSString*)getSeconde:(NSDate *)date{
    return [TimeUtil getTimeDayHourSecond:date formatString:@"ss"];
}
+(NSString*)nowTime:(NSString *)formatString{
    return [TimeUtil nsDataToString:[NSDate date] format:formatString];
}
@end
