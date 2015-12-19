//
//  BBGGoodsCommentListRequest.m
//  Common
//
//  Created by Holyjoy on 15/5/6.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGoodsCommentListRequest.h"
#import "Common.h"

@implementation BBGGoodsCommentListRequest

- (id)initWithFromUserCenter:(BOOL)FromUserCenter{
    
    self = [super init];
    if (self) {
        self.method = BBGHttpMethodPost;
        if (FromUserCenter) {
        }else{
        }
    }
    
    return self;
}

- (void)buildParameters:(BBGMutableParameters*)parameters {
    NSMutableDictionary *queryDic = [NSMutableDictionary dictionary];
    [queryDic DICT_SET_VK(@(_pageNumber),@"pageNumber")];
    [queryDic DICT_SET_VK(@(_size),@"size")];
    [queryDic DICT_SET_VK(_goodsId,@"goodsId")];
    [parameters addParameter:queryDic forKey:@"query"];
    [super buildParameters:parameters];
}

- (BOOL)needTimestamp {
    return YES;
}

- (BOOL)needAuthUser {
    
    return _isFromUserCenter?YES:NO;
}

- (Class)responseClass {
    return [BBGGoodsCommentListResponse class];
}


@end