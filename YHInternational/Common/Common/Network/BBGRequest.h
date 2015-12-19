//
//  BBGRequest.h
//  Common
//
//  Created by Damon on 15/4/7.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGHTTPClient.h"
#import "BBGResponseData.h"
#import "BBGResponse.h"
#import "BBGMacro.h"
//#import "BBGCommon.h"
//#import "BBGComponents.h"
@interface BBGRequest : BBGHTTPClient

@property (nonatomic, assign) BOOL notReturnErrorMsg;
/*!
 *  发起网络请求
 *
 *  @param success 成功block
 *  @param failure 失败block
 */
- (void)sendWithSuccessBlock:(void (^)(AFHTTPRequestOperation *operation, BBGResponse * responseData))success failure:(void (^)(AFHTTPRequestOperation *operation, NSString * errorMsg, NSString * errorCode))failure;

/*!
 *  发起网络请求
 *
 *  @param success 成功block
 *  @param failure 失败block
 *  @param data 上传进度
 */
- (void)sendWithSuccessBlock:(void (^)(AFHTTPRequestOperation *operation, BBGResponse * responseData))success
                     failure:(void (^)(AFHTTPRequestOperation *operation, NSString * errorMsg, NSString * errorCode))failure
                        data:(UploadDataBlock)uploadDataBlock;


/*!
 *  取消网络请求
 */
- (void)cancelRequest;



/*!
 *  网络请求的响应格式
 */
@property(nonatomic, assign) ResponseDataFormat responseFormat;

/*!
 *  网络请求的响应类
 */
- (Class)responseClass;

@end
