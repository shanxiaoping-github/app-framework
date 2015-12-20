//
//  RuntimeContext.m
//  WMF
//
//  Created by beijingwomaifang on 15/6/10.
//  Copyright (c) 2015年 beijingwomaifang. All rights reserved.
//

#import "RuntimeContext.h"
@interface RuntimeContext(){
    NSMutableDictionary* dataDictionary;
}
@end
@implementation RuntimeContext
/*
 *单例
 */
+(instancetype)shareInstance{
    static RuntimeContext* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
            instance  = [RuntimeContext new];
        }
    );
    return instance;
}
/*
 * 内存化数据
 */
-(void)putData:(id)value forkey:(NSString *)key{
    if (!dataDictionary) {
        dataDictionary = [NSMutableDictionary new];
    }
    [dataDictionary setObject:value forKey:key];
}
-(id)getData:(NSString *)key{
    if (dataDictionary) {
        return [dataDictionary objectForKey:key];
    }
    return nil;
}
-(void)putClassData:(id)value forkey:(Class)keyClass{
    [self putData:value forkey:NSStringFromClass(keyClass)];
}
-(id)getClasstData:(Class)keyClass{
    return [self getData:NSStringFromClass(keyClass)];
}


/*
 *持久化数据
 */
-(void)putConfiguration:(NSString *)value forkey:(NSString *)key{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:value forKey:key];
    
 }
-(NSString *)getConfiguration:(NSString *)key{
  NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
  NSString* value =  [userDefaults valueForKey:key];
  return value;
}
@end

