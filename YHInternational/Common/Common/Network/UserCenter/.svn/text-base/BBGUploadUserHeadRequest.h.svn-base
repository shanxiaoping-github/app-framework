
//
//  BBGUploadUserHeadRequest.h
//  Common
//
//  Created by yangjie on 15/4/28.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGRequest.h"

@interface BBGUploadUserHeadRequest : BBGRequest
/**
 *  用户头像
 */
@property (nonatomic,strong) NSData* headImgData;


/**
 *  用原生AFHTTPRequestOperationManager上传图片，暂取消
 *
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
- (void)uploadUserHeaderImg:(void (^)(AFHTTPRequestOperation *operation, BBGResponse * responseData))success failure:(void (^)(AFHTTPRequestOperation *operation, NSString * errorMsg, NSString * errorCode))failure;


@end
