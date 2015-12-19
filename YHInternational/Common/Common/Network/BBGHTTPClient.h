//
//  BBGHTTPClient.h
//  Common
//
//  Created by Damon on 15/4/6.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "BBGParameters.h"
#import "BBGConstants.h"
#import "BBGURLManager.h"

typedef void (^SuccessBlock) (AFHTTPRequestOperation *operation, id responseObject);

typedef void (^FailureBlock)(AFHTTPRequestOperation *operation, NSError * error);

typedef void (^UploadDataBlock)(NSUInteger bytes, long long totalBytes, long long totalBytesExpected);

/*!
 *  网络请求方法
 */
typedef enum {
    BBGHttpMethodNone = 0,
    BBGHttpMethodPost,
    BBGHttpMethodGet,
    BBGHttpUploadFile
} BBGHttpMethod;

@interface BBGHTTPClient : NSObject

/*!
 *  成功block
 */
@property (nonatomic, copy) SuccessBlock successBlock;

/*!
 *  失败block
 */
@property (nonatomic, copy) FailureBlock failureBlock;

/*!
 *  上传进度block
 */
@property (nonatomic, copy) UploadDataBlock uploadDataBlock;
/*!
 *  网络请求的服务名称
 */
@property(nonatomic, strong) NSString *serviceName;


/*!
 *  网络请求的参数
 */
@property(weak, nonatomic, readonly) BBGParameters *parameters;

/*!
 *  创建头部
 */
- (void)buildHeaders:(BBGMutableParameters *)headers;

/**
 *  @author Damon, 15-04-07 07:04:38
 *
 *  设置参数
 *
 */
- (void)buildParameters:(BBGMutableParameters *)parameters;

/**
 *  @author Damon, 15-04-07 07:04:53
 *
 *  AFNetworking
 */
@property (nonatomic, strong) AFHTTPRequestOperationManager * manager;

/*!
 *  网络请求的方法
 */
@property(nonatomic, assign) BBGHttpMethod method;

/*!
 *  网络请求超时时间
 */
@property(nonatomic, assign) NSTimeInterval timeOut;

/*!
 *  网络请求的参数
 */
@property(weak, nonatomic, readonly) BBGParameters *headers;

/**
 *  图片文件二进制
 */
@property (nonatomic,strong) NSData *imgData;

/**
 *  图片文件数组
 */
@property (nonatomic,strong) NSArray *willUploadImgArray;

/*!
 *  @author Damon, 15-04-07 17:04:10
 *
 *  设置平台参数
 *
 */
- (BOOL)setPlatform;

/*!
 *  @author Damon, 15-04-07 18:04:42
 *
 *  是否需要传输地址
 *
 */
- (BOOL)setArea;

/*!
 *  是否需要验证用户信息
 *
 *  @return NO
 */
- (BOOL)needAuthUser;
/*!
 *  需要验证系统时间
 *
 *  @return NO
 */
- (BOOL)needTimestamp;
/**
 *  @author Damon, 15-04-07 07:04:03
 *
 *  创建请求的URL
 *
 *  @return url
 */
- (NSString *)buildRequestURL;

- (void)send;

- (void)successWithOperation:(AFHTTPRequestOperation *)operation responseObject:(id)responseObject error:(NSError *)error;

@end
