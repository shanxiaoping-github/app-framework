//
//  BBGUploadIDPhotoRequest.m
//  Common
//
//  Created by Holyjoy on 15/6/8.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGUploadIDPhotoRequest.h"
#import "BBGUploadIDPhotoResponse.h"
#import "BBGSession.h"
#import "NSString+Encryption.h"

@implementation BBGUploadIDPhotoRequest

- (instancetype)init{
    self = [super init];
    if (self) {
        self.method = BBGHttpUploadFile;
    }
    return self;
}

- (NSString *)buildRequestURL{
    NSString * url = [NSString stringWithFormat:@"%@/upload",SERVER_URL];
    return url;
}

- (void)buildParameters:(BBGMutableParameters *)parameters{
    [super buildParameters:parameters];
}

- (BOOL)needAuthUser {
    return YES;
}


- (void)uploadIDPhoto:(void (^)(AFHTTPRequestOperation *operation, BBGResponse * responseData))success failure:(void (^)(AFHTTPRequestOperation *operation, NSString * errorMsg, NSString * errorCode))failure{
    
    __weak BBGRequest *weakSelf = self;
    self.successBlock = ^(AFHTTPRequestOperation *operation, id responseObject) {
        
        Class responseClass = [weakSelf responseClass];
        if(![responseClass isSubclassOfClass:[BBGResponse class]]){
            @throw [NSException exceptionWithName:@"类型错误" reason:@"responseClass必须为BBGResponse的子类" userInfo:nil];
        }
        BBGResponse * response = [[responseClass alloc] initWithData:responseObject format:ResponseDataFormatJson];
        NSLog(@"response:%@",[response description]);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                success(operation,response);
            }
        });
    };
    
    self.failureBlock = ^(AFHTTPRequestOperation *operation, NSError *error) {
        
    };
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/upload",SERVER_URL];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObject:@"text/html/json"];
    [manager POST:urlStr parameters:[self parametersDict] constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:_IDPhotoData name:@"Filedata" fileName:@"header.jpg" mimeType:@"image/jpg"];
    } success:self.successBlock failure:self.failureBlock];
    
}


-(NSMutableDictionary*)parametersDict{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    if ( [BBGSession sharedInstance].isLogin) {
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
    return parameters;
}


- (Class)responseClass{
    return [BBGUploadIDPhotoResponse class];
}



@end
