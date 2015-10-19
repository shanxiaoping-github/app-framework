//
//  HttpClientManager.h
//  mqsystem
//  Created by shanxiaoping on 15-1-31.
//  Copyright (c) 2015年 yicai. All rights reserved.
//
#define baseUrl @"http://app.womaif.com/?"
#define NOMAL @"nomal"//正常
#define ERROR @"error"//错误
#import <Foundation/Foundation.h>
#import "HttpEvent.h"
/*请求模型*/
@protocol RequestModel <NSObject>
/*获取参数*/
-(NSArray*)getParameKey;
/*解析回包数据*/
-(void)parseResponse:(NSString*)resultType result:(NSString*)result response:(id)response;
@end
/*客户端发起服务管理*/
@interface HttpClientManager : NSObject<RequestModel>
/*httpEvent请求*/
@property(nonatomic,strong)HttpEvent* event;
/*提交httpEven事件*/
-(void)submitHttpEvent;
-(void)submitHttpEvent:(NSString*)type;

-(void)submitRequset:(NSString*)type url:(NSString*)url parames:(NSArray*)parames success:(void (^) (id result,id response))success faile:(void(^)(id result,NSError* error))faile;
-(void)submitRequset:(NSString*)url parames:(NSArray*)parames success:(void (^)(id result,id response))success faile:(void (^)(id result,NSError *error))faile;
/*对参数进行过滤*/
-(NSDictionary*)filterParamers:(NSDictionary*)parames;
/*获取基本url*/
-(NSString*)getBaseUrl;
/*获得url*/
- (NSString *)getUrl:(NSString *)actionUrl;
@end
