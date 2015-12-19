//
//  BBGHTTPClient.m
//  Common
//
//  Created by Damon on 15/4/6.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGHTTPClient.h"
#import "BBGConstants.h"
#import "JSONKit.h"
#import "BBGSession.h"
#import "NSString+Encryption.h"
#import "BBGConfiguration.h"
#import "APService.h"
@interface BBGHTTPClient ()

@property (nonatomic,strong) UIDevice *device;

@end

@implementation BBGHTTPClient{
    BBGMutableParameters *_parameters;
    BBGMutableParameters *_headers;
}

- (id)init{
    self = [super init];
    if (self) {
        _device = [[UIDevice alloc] init];
        _parameters = [[BBGMutableParameters alloc]init];
        _headers = [[BBGMutableParameters alloc] init];
        _timeOut = 10;
    }
    return self;
}

- (void)send{
    
    if (_manager) {
        [_manager.operationQueue cancelAllOperations];
        _manager = nil;
    }
    _manager = [AFHTTPRequestOperationManager manager];
    
    /*!
     *  @author Damon, 15-04-07 16:04:34
     *
     *  设置头部
     */
    _manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    _manager.requestSerializer.timeoutInterval = _timeOut;
    
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html/json", nil];
    
    /*!
     *  系统版本和平台
     */
    //    [_manager.requestSerializer setValue:@"version" forHTTPHeaderField:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]];
    
    BBGParameters *headers = [self headers];
    NSDictionary *headersDictionary = [headers dictionary];
    for (NSString *key in headersDictionary.allKeys) {
        [_manager.requestSerializer setValue:headersDictionary[key] forHTTPHeaderField:key];
    }
    
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    
    /*!
     *  系统参数
     *  1:versionCode 内部开发版本号
     *  2:version 外部版本号
     */
    [parameters setValue:APPVERSION forKey:@"versionCode"];
    [parameters setValue:APPOUTVERSION forKey:@"version"];
    
    //上传推送ID
    NSString *pushID = [APService registrationID];
    if (![BBGTools checkStringIsBlank:pushID]) {
         [parameters setValue:pushID forKey:@"JGpushID"];
    }
    
    [parameters setValue:@"ios" forKey:@"source"];
    
    [parameters setValue:CHANNEL_ID forKey:@"mChannel"];
    [parameters setValue:_device.model forKey:@"phoneModel"];
    [parameters setValue:[NSString stringWithFormat:@"IOS%@",_device.systemVersion] forKey:@"systemVersion"];
    
    if (self.serviceName) {
        [parameters setValue:self.serviceName forKey:@"method"];
    }
    
    [parameters setValue:[BBGConfiguration sharedInstance].eCode forKey:@"eCode"];
    [parameters setValue:[BBGConfiguration sharedInstance].uCode forKey:@"uCode"];
    /*!
     *  @author Damon, 15-04-07 20:04:39
     *
     *  加入业务参数
     */
    NSString *parametersStr = [NSString stringWithFormat:@"%@",[self parameters]];

    [parameters setValue:parametersStr forKey:@"params"];
    
    /*!
     *  添加时间参数
     */
    if ([self needTimestamp]) {
        NSNumber * requestTime = [[NSUserDefaults standardUserDefaults] objectForKey:@"timeDifference"];
        NSDate * date = [NSDate date];
        
        double time = date.timeIntervalSince1970 - requestTime.doubleValue;
        
        NSString * timestamp = [[NSString alloc] initWithCString:[[NSString stringWithFormat:@"%.0f",time * 1000] UTF8String] encoding:NSUTF8StringEncoding];
        
        [parameters setValue:timestamp forKey:@"timestamp"];
    }
    
    if ([self needAuthUser]) {
            [[BBGSessionManager sharedInstance]doLogin:^(BOOL successful) {
                if (successful) {
                NSString * token = [BBGSession sharedInstance].userInfo.accessToken;
                [parameters setValue:token forKey:@"accessToken"];
                /*!
                 *  @author Damon, 15-04-10 10:04:42
                 *
                 *  签名字段加密
                 */
                NSString * secretParameter = @"";
                NSString * userSecret = [BBGSession sharedInstance].userInfo.userSecret;
                secretParameter = [secretParameter stringByAppendingFormat:@"%@",userSecret];
                /*!
                 *  @author Damon, 15-04-23 19:04:50
                 *
                 *  请求时间
                 */
                
                NSNumber * requestTime = [[NSUserDefaults standardUserDefaults] objectForKey:@"timeDifference"];
                NSDate * date = [NSDate date];
                double time = date.timeIntervalSince1970 - requestTime.doubleValue;
                
                NSString * timestamp = [[NSString alloc] initWithCString:[[NSString stringWithFormat:@"%.0f",time * 1000] UTF8String] encoding:NSUTF8StringEncoding];
                [parameters setValue:timestamp forKey:@"timestamp"];
                
                secretParameter =[secretParameter stringByAppendingFormat:@"%@=%@",@"accessToken",parameters[@"accessToken"]];
                secretParameter =[secretParameter stringByAppendingFormat:@"%@=%@",@"method",parameters[@"method"]];
                secretParameter =[secretParameter stringByAppendingFormat:@"%@=%@",@"version",parameters[@"version"]];
                secretParameter =[secretParameter stringByAppendingFormat:@"%@=%@",@"timestamp",timestamp];
                secretParameter =[secretParameter stringByAppendingFormat:@"%@=%@",@"params",parameters[@"params"]];
                
                secretParameter =[secretParameter stringByAppendingFormat:@"%@",userSecret];
                
                secretParameter = [secretParameter md5String];
                [parameters setValue:secretParameter forKey:@"sign"];
                }
            }];

    }
#ifdef DEBUG
    NSLog(@"url:%@\nparameters:%@",[self buildRequestURL],parameters);
#endif
    if (self.method == BBGHttpMethodGet) {
        [self.manager GET:[self buildRequestURL] parameters:parameters success:self.successBlock failure:self.failureBlock];
    }else if (self.method == BBGHttpMethodPost){
        [self.manager POST:[self buildRequestURL] parameters:parameters success:self.successBlock failure:self.failureBlock];
    }else if (self.method == BBGHttpUploadFile){
        if (_imgData != nil) {
           AFHTTPRequestOperation *operation = [self.manager POST:[self buildRequestURL] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                [formData appendPartWithFileData:_imgData name:@"Filedata" fileName:@"header.jpg" mimeType:@"image/jpg"];
            } success:self.successBlock failure:self.failureBlock];
            
            if (self.uploadDataBlock) {
                [operation setUploadProgressBlock:self.uploadDataBlock];
            }


        }else{

//            [self.manager POST:[self buildRequestURL] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//                for (int i = 0; i<[_imgArray COUNT]; i++) {
//                    UIImage *img = [_imgArray ARRAY_OBJ_AT(i)];
//                    [formData appendPartWithFileData:UIImageJPEGRepresentation(img, 0.8) name:[NSString stringWithFormat:@"参数%d",i+1] fileName:@"img" mimeType:@"image/jpg"];
//                }
//
//            } success:self.successBlock failure:self.failureBlock];
            
            
            for (int i=0; i<[_willUploadImgArray COUNT]; i++) {
                UIImage *img = [_willUploadImgArray ARRAY_OBJ_AT(i)];
                [self.manager POST:[self buildRequestURL] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                    [formData appendPartWithFileData:UIImageJPEGRepresentation(img, 0.02) name:@"FileData" fileName:@"img" mimeType:@"image/jpg"];
                } success:self.successBlock failure:self.failureBlock];
            }
        }
    }
    
}

- (void)successWithOperation:(AFHTTPRequestOperation *)operation responseObject:(id)responseObject error:(NSError *)error{
    
}

- (BBGParameters *)headers {
    [_headers clearAllParameter];
    [self buildHeaders:_headers];
    return _headers;
}

- (void)buildHeaders:(BBGMutableParameters *)headers {
}

- (NSString *)parameters {
    [_parameters clearAllParameter];
    [self buildParameters:_parameters];
    return [_parameters buildParameters];
}

- (void)resetParameters {
    [_parameters clearAllParameter];
    [self buildParameters:_parameters];
}

- (void)buildParameters:(BBGMutableParameters *)parameters {
    
}

- (NSString *)buildRequestURL{
    
    NSString * url = [NSString stringWithFormat:@"%@/service",SERVER_URL];
    return url;
}

- (BOOL)setArea{
    return NO;
}

- (BOOL)needAuthUser{
    if ([BBGSession sharedInstance].isLogin) {
        return YES;
    }
    return NO;
}

- (BOOL)needTimestamp{
    return NO;
}

- (BOOL)setPlatform{
    return NO;
}

- (void)cancel{
    [self.manager.operationQueue cancelAllOperations];
    self.manager = nil;
}

- (void)dealloc{
    [self cancel];
    self.successBlock = nil;
    self.failureBlock = nil;
    [_parameters clearAllParameter];
    _parameters = nil;
    self.serviceName = nil;
    self.manager = nil;
    self.imgData = nil;
    self.willUploadImgArray = nil;
    
}

@end
