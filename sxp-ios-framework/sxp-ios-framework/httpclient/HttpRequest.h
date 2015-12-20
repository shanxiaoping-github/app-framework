//
//  HttpRequestEvent.h
//  gigold
//  Created by 单小萍 on 15/11/27.
//  Copyright © 2015年 wsc. All rights reserved.
//  http请求事件
//
#define NOMAL @"nomal"//正常
#define ERROR @"error"//错误

#import <Foundation/Foundation.h>
#import "HttpConfiguration.h"
#import "HttpResponse.h"
@class HttpRequestTransaction;
@interface HttpRequest : NSObject
//所属http事务
@property(nonatomic,weak)HttpRequestTransaction* belongHttpRequestTransaction;
//依赖的请求事件
@property(nonatomic,weak)id dependentHttpRequestEvent;
//被依赖的事件集合
@property(nonatomic,strong)NSMutableArray* nextHttpRequestEventArray;
//请求配置
@property(nonatomic,strong)HttpConfiguration* httpConfiguration;
//解析数据后的响应
@property(nonatomic,strong)HttpResponse* httpResponse;
//url
@property(nonatomic,copy)NSString* url;
//action
@property(nonatomic,copy)NSString* action;
//拦截器
@property(nonatomic,assign)BOOL interceptSubmit;

//获取参数列表key
-(NSArray*)getPramaKeys;
//设置参数值
-(void)setPramaValues:(NSArray*)values;
//对参数进行过滤
-(NSDictionary*)filterParamers:(NSDictionary*)parames;
//添加下一个http请求
-(void)addNextHttpRequestEvent:(HttpRequest*)httpRequestEvent;
//解析数据
-(void)parseResponse:(NSString*)resultType result:(NSString*)result response:(id)response;
//提交请求
-(void)submitRequest;
//获取依赖请求上下文
-(void)getSubRequestContext:(id)sender;
//作为依赖http请求被提交
-(void)submitSubRequest:(id)sender;
//获得url
-(NSString*)getUrl;
//获得action
-(NSString*)getAction;

@end
