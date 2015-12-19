//
//  HttpConfiguration.m
//  gigold
//
//  Created by 单小萍 on 15/11/27.
//  Copyright © 2015年 wsc. All rights reserved.
//
#import "HttpConfiguration.h"
@implementation HttpConfiguration
@synthesize httpRequestType=_httpRequestType;
@synthesize url=_url;
@synthesize action=_action;
@synthesize params=_params;
//添加参数
-(void)addParam:(NSString *)paramKey value:(id)paramValue{
    if (!_params) {
        self.params = [[NSMutableDictionary alloc]init];
    }
    [_params setValue:paramValue forKey:paramKey];
}
//获取url
+(NSString *)getUrl:(NSString *)url action:(NSString *)action{
    return [NSString stringWithFormat:@"%@%@",url,action];
}
@end
