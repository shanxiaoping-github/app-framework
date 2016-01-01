//
//  HttpConfiguration.m
//  gigold
//
//  Created by 单小萍 on 15/11/27.
//  Copyright © 2015年 wsc. All rights reserved.
//
#import "HttpConfiguration.h"
#import "MJExtension.h"
@implementation HttpConfiguration
@synthesize httpRequestType = _httpRequestType;
@synthesize url = _url;
@synthesize action = _action;
@synthesize params = _params;
@synthesize parameModel = _parameModel;

-(NSDictionary *)getParames{
    if (_params) {
        return _params;
    }
    if (_parameModel) {
        return [_parameModel keyValues];
    }
    return nil;
}


-(void)addParam:(NSString *)paramKey value:(id)paramValue{
    if (!_params) {
        self.params = [[NSMutableDictionary alloc]init];
    }
    [_params setValue:paramValue forKey:paramKey];
}

+(NSString *)getUrl:(NSString *)url action:(NSString *)action{
    return [NSString stringWithFormat:@"%@%@",url,action];
}
@end
