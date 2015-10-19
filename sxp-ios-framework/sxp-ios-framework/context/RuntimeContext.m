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

//存入数据
+(instancetype)getInstane{
    static RuntimeContext* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
            instance  = [RuntimeContext new];
        }
    );
    return instance;
}

-(void)putData:(id)value forkey:(NSString *)key{
    if (!dataDictionary) {
        dataDictionary = [NSMutableDictionary new];
    }
    [dataDictionary setObject:value forKey:key];
}
//拿数据
-(id)getData:(NSString *)key{
    if (dataDictionary) {
        return [dataDictionary objectForKey:key];
    }
    return nil;
}
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

