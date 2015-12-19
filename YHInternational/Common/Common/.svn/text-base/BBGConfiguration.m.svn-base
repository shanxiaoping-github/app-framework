//
//  BBGConfiguration.m
//  Common
//
//  Created by Damon on 15/4/10.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGConfiguration.h"
#import "BBGMacro.h"
#import <UIKit/UIKit.h>
#import "BBGCache.h"
#import "OpenUDID.h"
#import "BBGConstants.h"
#import "BBGTools.h"
/*!
 *  @author Damon, 15-04-10 13:04:00
 *
 *  做部分标志位的存储，请使用 synchronize
 */
@interface BBGConfiguration()
@property (nonatomic,strong)NSUserDefaults *userDefaults;

@end

@implementation BBGConfiguration

@synthesize theme = _theme;

DECLARE_SINGLETON(BBGConfiguration)

- (id)init {
    self = [super init];
    if (self) {
        self.userDefaults = [NSUserDefaults standardUserDefaults];

    }
    return self;
}

- (NSString *)theme{
    if ([BBGTools checkStringIsBlank:_theme]){
        return @"DefaultTheme";
    }
    return _theme;
}

- (void)setTheme:(NSString *)theme{
    _theme = [theme copy];
}

- (UIImage *)imageWithImageName:(NSString *)imageName{
    NSString *directory = [NSString stringWithFormat:@"%@", [self theme]];
    
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageName
                                                          ofType:@"png"
                                                     inDirectory:directory];
    
    return [UIImage imageWithContentsOfFile:imagePath];
}

- (void)setAreaVersion:(NSString *)areaVersion{
    if ([self.userDefaults objectForKey:@"areaVersion"]) {
        [self.userDefaults removeObjectForKey:@"areaVersion"];
        [self.userDefaults synchronize];
    }
    [self.userDefaults setObject:areaVersion forKey:@"areaVersion"];
    [self.userDefaults synchronize];
}

- (NSString *)areaVersion{
    return [self.userDefaults objectForKey:@"areaVersion"];
}

- (void)getTimeDifferenceWithServerTime:(NSString *)serverTime{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    [dateFormatter setDateFormat:@"EEE',' dd MMM yyyy HH':'mm':'ss 'GMT'"];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSDate * serverDate = [dateFormatter dateFromString:serverTime];
    
    self.serverTime = serverDate;
    
    NSDate * localDate = [NSDate date];
    
    NSTimeInterval timeDifference = localDate.timeIntervalSince1970 - serverDate.timeIntervalSince1970;
    NSNumber * time = [NSNumber numberWithDouble:timeDifference];
    [self.userDefaults setObject:time forKey:@"timeDifference"];
    [self.userDefaults synchronize];
}
-(NSDate*) getCurrentServerTime{
    NSNumber * requestTime = [[NSUserDefaults standardUserDefaults] objectForKey:@"timeDifference"];
    NSDate * date = [NSDate date];
    
    double time = date.timeIntervalSince1970 - requestTime.doubleValue;
    NSDate * currentDate = [NSDate dateWithTimeIntervalSince1970:time];
    return currentDate;
}

- (NSString *)getECode{
    if (![self.userDefaults objectForKey:@"eCode"]) {
        NSString * str = [OpenUDID value];
        str = [str stringByReplacingOccurrencesOfString:@"-" withString:@""];
        str = [str substringToIndex:15];
        [self.userDefaults setObject:str forKey:@"eCode"];
        [self.userDefaults synchronize];
    }
    return [self.userDefaults objectForKey:@"eCode"];
}

- (NSString *)getUCode{
    if (![self.userDefaults objectForKey:@"uCode"]) {
        NSString * str = [OpenUDID value];
        str = [str stringByReplacingOccurrencesOfString:@"-" withString:@""];
        str = [str substringWithRange:NSMakeRange(17,15)];
        [self.userDefaults setObject:str forKey:@"uCode"];
        [self.userDefaults synchronize];
    }
    return [self.userDefaults objectForKey:@"uCode"];
}

- (NSString *)eCode{
   
    return [self getECode];
}

- (NSString *)uCode{
    return [self getUCode];
}

- (void)dealloc{
    self.areaVersion = nil;
    self.userDefaults = nil;
}


@end
