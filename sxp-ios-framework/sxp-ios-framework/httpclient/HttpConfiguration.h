//
//  HttpConfiguration.h
//  gigold
//  Created by 单小萍 on 15/11/27.
//  Copyright © 2015年 wsc. All rights reserved.
//  http配置

#import <Foundation/Foundation.h>
#import "HttpUtil.h"
@interface HttpConfiguration : NSObject
//提交类型，默认为post
@property(nonatomic,assign)HttpRequestType httpRequestType;
//请求地址
@property(nonatomic,copy)NSString* url;
//请求action
@property(nonatomic,copy)NSString* action;
//请求参数
@property(nonatomic,strong)NSMutableDictionary* params;
/*
 *添加参数
 *paramKey 参数键值
 *paramValue 
 */
-(void)addParam:(NSString*)paramKey value:(id)paramValue;

/*
 *获取url全地址
 *url
 *action
 */
+(NSString*)getUrl:(NSString*)url action:(NSString*)action;


@end
