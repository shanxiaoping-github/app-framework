//
//  BBGCommentListRequest.m
//  Common
//
//  Created by Holyjoy on 15/4/23.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGCommentListRequest.h"
#import "BBGCommentListResponse.h"
#import "Common.h"

@implementation BBGCommentListRequest

- (id)init {
    self = [super init];
    if (self) {
        self.method = BBGHttpMethodPost;
    }
    
    return self;
}

- (void)buildParameters:(BBGMutableParameters*)parameters {
    NSMutableDictionary *queryDic = [NSMutableDictionary dictionary];
    [queryDic DICT_SET_VK(@(_pageNumber),@"pageNumber")];
    [queryDic DICT_SET_VK(@(_size),@"size")];
    [parameters addParameter:queryDic forKey:@"query"];
    [super buildParameters:parameters];
}

- (BOOL)needTimestamp {
    return YES;
}

- (BOOL)needAuthUser {
    
    return YES;
}

- (Class)responseClass {
    return [BBGCommentListResponse class];
}


@end
