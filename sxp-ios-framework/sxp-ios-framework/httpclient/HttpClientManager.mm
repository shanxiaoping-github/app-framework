//
//  HttpClientManager.m
//  mqsystem
//
//  Created by shanxiaoping on 15-1-31.
//  Copyright (c) 2015年 yicai. All rights reserved.
//

#import "HttpClientManager.h"
#import "HttpEvent.h"
#import "AFHTTPRequestOperationManager.h"
#define GET_TYPE @"GET"
#define POST_TYPE @"POST"

@implementation HttpClientManager
@synthesize event = _event;

/*获得地址*/
- (NSString *)getUrl:(NSString *)actionUrl {
  return [[self getBaseUrl] stringByAppendingString:actionUrl];
}

- (NSString *)getBaseUrl {
  return baseUrl;
}
/**
 *默认提交post请求
 */
- (void)submitHttpEvent {
  [self submitHttpEvent:POST_TYPE];
}
/*提交请求*/
- (void)submitHttpEvent:(NSString *)type {

  if (_event) {
    AFHTTPRequestOperationManager *afhManager =
        [AFHTTPRequestOperationManager manager];
      if ([type isEqualToString:POST_TYPE]) {
      [afhManager POST:[self getUrl:_event.actionUrl]
          parameters:
              [self filterParamers:[self getParameDictionary:_event.parames]]
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              
            [self parseResponse:NOMAL
                         result:operation.responseString
                       response:responseObject];

              if (_event) {
                  [_event.callBack success:self response:responseObject];
              }

          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
            [self parseResponse:ERROR
                         result:operation.responseString
                       response:error];
              if (_event.callBack) {
                  [_event.callBack error:self error:error];
              }
          }];

    } else if ([type isEqualToString:GET_TYPE]) {
      [afhManager GET:[self getUrl:_event.actionUrl]
          parameters:
              [self filterParamers:[self getParameDictionary:_event.parames]]
          success:^(AFHTTPRequestOperation *operation, id responseObject) {

            [self parseResponse:NOMAL
                         result:operation.responseString
                       response:responseObject];
            if (_event.callBack) {
              [_event.callBack success:self response:responseObject];
            }

          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self parseResponse:ERROR
                         result:operation.responseString
                       response:error];
            if(_event.callBack) {
              [_event.callBack error:self error:error];
            }
          }];
    }
  }
}
/*
 *提交请求
 */

- (void)submitRequset:(NSString *)type
                  url:(NSString *)url
              parames:(NSArray *)parames
              success:(void (^)(id result, id response))success
                faile:(void (^)(id result, NSError *error))faile {

  AFHTTPRequestOperationManager *afhManager =
      [AFHTTPRequestOperationManager manager];
  
  if ([type isEqualToString:POST_TYPE]) {
    [afhManager POST:[self getUrl:url]
        parameters:[self filterParamers:[self getParameDictionary:parames]]
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self parseResponse:NOMAL
                       result:operation.responseString
                     response:responseObject];
            if (success) {
                success(self, responseObject);
            }
            
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self parseResponse:ERROR
                       result:operation.responseString
                     response:error];
            if(faile){
                faile(self, error);
            }
        }];

  } else if ([type isEqualToString:GET_TYPE]){
    [afhManager GET:[self getUrl:url]
        parameters:[self filterParamers:[self getParameDictionary:parames]]
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
                [self parseResponse:NOMAL
                       result:operation.responseString
                     response:responseObject];
            if (success) {
                success(self, responseObject);
            }

        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                            [self parseResponse:ERROR
                       result:operation.responseString
                     response:error];
            if (faile) {
                faile(self, error);
            }
        }];
  }
}

/**
 *提交默认post
 */
- (void)submitRequset:(NSString *)url
              parames:(NSArray *)parames
              success:(void (^)(id result, id response))success
                faile:(void (^)(id result, NSError *error))faile {
  [self submitRequset:POST_TYPE
                  url:url
              parames:parames
              success:success
                faile:faile];
}

- (void)parseResponse:(NSString *)resultType
               result:(NSString *)result
             response:(id)response {
}
/*获得参数列表*/
- (NSArray *)getParameKey{
  return nil;
}

/*过滤*/
- (NSDictionary *)filterParamers:(NSDictionary *)parames {
  return parames;
}
/*获取参数字典*/
- (NSDictionary *)getParameDictionary:(NSArray *)values {
  NSArray *keys = [self getParameKey];
  if (keys && values) {
    if ([keys count] != [values count]) {
      @throw [[NSException alloc] initWithName:@"请求参数异常:"
                                        reason:@"参数不匹配"
                                      userInfo:nil];
        }else {
        NSMutableDictionary *parames = [NSMutableDictionary new];
        for (int i = 0; i < [keys count]; i++) {
        NSString *key = [keys objectAtIndex:i];
        NSString *value = [values objectAtIndex:i];
        [parames setValue:value forKey:key];
      }
      return parames;
    }
  } else {
      return nil;
  }
}
@end
