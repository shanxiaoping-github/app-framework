//
//  BBGUploadIDPhotoRequest.h
//  Common
//
//  Created by Holyjoy on 15/6/8.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGRequest.h"

@interface BBGUploadIDPhotoRequest : BBGRequest

/**
 *  用户身份证照片
 */
@property (nonatomic,strong) NSData* IDPhotoData;


/**
 *  用原生AFHTTPRequestOperationManager上传图片，暂取消
 *
 *  @param success
 *  @param failure
 */
- (void)uploadIDPhoto:(void (^)(AFHTTPRequestOperation *operation, BBGResponse * responseData))success failure:(void (^)(AFHTTPRequestOperation *operation, NSString * errorMsg, NSString * errorCode))failure;



@end
