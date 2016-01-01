//
//  HttpConfiguration.h
//  gigold
//  Created by 单小萍 on 15/11/27.
//  Copyright © 2015年 wsc. All rights reserved.
//  http配置

#import <Foundation/Foundation.h>
#import "HttpUtil.h"
#import "HttpParameModel.h"
@interface HttpConfiguration : NSObject
//提交类型，默认为post
@property(nonatomic,assign)HttpRequestType httpRequestType;
//请求地址
@property(nonatomic,copy)NSString* url;
//请求action
@property(nonatomic,copy)NSString* action;
//请求参数
@property(nonatomic,strong)NSMutableDictionary* params;
//请求参数model
@property(nonatomic,strong)HttpParameModel* parameModel;
/*!
 @author shanxiaoping
 
 @brief 获取参数
 
 @return 返回参数
 */
-(NSDictionary*)getParames;
/*!
 @author shanxiaoping
 
 @brief 添加参数
 
 @param paramKey   参数key
 @param paramValue 参数value
 */
-(void)addParam:(NSString*)paramKey value:(id)paramValue;
/*!
 @author shanxiaoping
 
 @brief 获取url
 
 @param url    url
 @param action action
 
 @return 返回拼装后的url
 */
+(NSString*)getUrl:(NSString*)url action:(NSString*)action;
@end
