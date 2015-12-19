//
//  BBGMaternalORBeautyRequest.m
//  Common
//
//  Created by 刘薇 on 15/7/13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGMaternalORBeautyRequest.h"
#import "BBGMaternalOrBeautyResponse.h"
@implementation BBGMaternalORBeautyRequest
- (id)init{
    self = [super init];
    if (self) {
        self.method = BBGHttpMethodPost;
        _pageSize = 20 ;
    }
    return self;
}

- (void)buildParameters:(BBGMutableParameters *)parameters{
    
    [parameters addParameter:[NSString stringWithFormat:@"%ld",(long)self.tagType] forKey:@"tagType"];
//    [parameters addParameter:[NSString stringWithFormat:@"%ld",(long)_pageNumber] forKey:@"pageNumber"];
    [parameters addParameter:[NSString stringWithFormat:@"%ld",(long)_pageSize] forKey:@"pageSize"];
    [super buildParameters:parameters];
}

- (Class)responseClass{
    return [BBGMaternalOrBeautyResponse class];
}

@end