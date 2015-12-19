//
//  BBGUploadImgRequest.m
//  Common
//
//  Created by yangjie on 15/5/19.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGUploadImgRequest.h"
#import "BBGUploadImgResponse.h"

@implementation BBGUploadImgRequest

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
    if (self.isUseBase64) {
        [parameters addParameter:@"1" forKey:@"base64"];
    }
    [super buildParameters:parameters];
}

- (BOOL)needAuthUser {
    if (_isNotLogin) {
        return NO;
    }else{
        return YES;
    }
}


- (Class)responseClass{
    return [BBGUploadImgResponse class];
}


@end
