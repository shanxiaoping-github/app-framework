//
//  HttpUtil.m
//  gigold
//
//  Created by 单小萍 on 15/11/27.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "HttpUtil.h"
@implementation HttpUtil
+(void)sendHttpRequest:(HttpRequestType)httpRequestType url:(NSString *)url params:(id)params success:(void (^)(AFHTTPRequestOperation *, id))success faile:(void (^)(id, NSError *))faile{
	
	NSLog(@"\n发送数据-url:%@ params:%@\n",url,params);

    AFHTTPRequestOperationManager *afhManager =
    [AFHTTPRequestOperationManager manager];
    NSMutableSet *contentTypes = [[NSMutableSet alloc] initWithSet:afhManager.responseSerializer.acceptableContentTypes];
    [contentTypes addObject:@"text/html"];
    afhManager.responseSerializer.acceptableContentTypes = contentTypes;
    switch (httpRequestType) {
        case HttpRequestTypeGet:{
            [afhManager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    success(operation,responseObject);
                    NSLog(@"返回数据-%@",responseObject);
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    faile(operation,error);
                    NSLog(@"返回错误-%@",error);
                }];
            }
            break;
        case HttpRequestTypePost:{
                [afhManager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    success(operation,responseObject);
                    NSLog(@"返回数据-%@",responseObject);
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    faile(operation,error);
                    NSLog(@"返回错误-%@",error);
                }];
            }
            break;
    }
}
+(void)sendHttpRequest:(NSString *)url params:(id)params success:(void (^)(AFHTTPRequestOperation *, id))success faile:(void (^)(id, NSError *))faile{
    [HttpUtil sendHttpRequest:HttpRequestTypePost url:url params:params success:success faile:faile];
}

@end
