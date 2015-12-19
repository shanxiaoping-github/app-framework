//
//  BBGUnEvaluateRequest.m
//  Common
//
//  Created by Holyjoy on 15/5/19.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGUnEvaluateRequest.h"
#import "BBGUnEvaluateResponse.h"
#import "Common.h"

@implementation BBGUnEvaluateRequest

- (instancetype)init{
    self = [super init];
    if (self) {
        self.method = BBGHttpMethodPost;
        _pageIndex = 1;
        _pageSize = 20;
    }
    return self;
}

- (void)buildParameters:(BBGMutableParameters *)parameters{
   
    NSMutableDictionary *queryDic = [NSMutableDictionary dictionary];
    [queryDic DICT_SET_VK(@(_pageIndex),@"pageNumber")];
    [queryDic DICT_SET_VK(@(_pageSize),@"size")];
    [parameters addParameter:queryDic forKey:@"query"];
    [super buildParameters:parameters];
}


- (BOOL)needAuthUser{
    return YES;
}

- (Class)responseClass {
    
    return [BBGUnEvaluateResponse class];
}


@end
