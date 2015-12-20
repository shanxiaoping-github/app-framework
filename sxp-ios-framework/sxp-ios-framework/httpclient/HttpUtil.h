//
//  HttpUtil.h
//  gigold
//  Created by 单小萍 on 15/11/27.
//  Copyright © 2015年 wsc. All rights reserved.
//   网络连接工具类
//
#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"
typedef NS_ENUM(NSInteger,HttpRequestType){
    HttpRequestTypeGet  = 1 << 0,
    HttpRequestTypePost = 1 << 1
};
@interface HttpUtil : NSObject
/*
 *发送http请求
 *httpRequestType 请求枚举类型
 *url 请求地址
 *params 请求参数
 *success 成功block
 *faile 失败block
 */
+(void)sendHttpRequest:(HttpRequestType)httpRequestType url:(NSString*)url params:(id)params success:(void(^)(AFHTTPRequestOperation *operation, id responseObject))success faile:(void(^)(id result,NSError* error))faile;
/*
 *发送http请求
 *url 请求地址
 *params 请求参数
 *success 成功block
 *faile 失败block
 */
+(void)sendHttpRequest:(NSString*)url params:(id)params success:(void(^)(AFHTTPRequestOperation *operation, id responseObject))success faile:(void(^)(id result,NSError* error))faile;

@end
