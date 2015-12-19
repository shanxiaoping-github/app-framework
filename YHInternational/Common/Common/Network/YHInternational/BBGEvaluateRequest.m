//
//  BBGEvaluateRequest.m
//  Common
//
//  Created by Holyjoy on 15/5/11.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGEvaluateRequest.h"
#import "BBGEvaluateResponse.h"
#import "Common.h"

@implementation BBGEvaluateRequest
- (id)init {
    self = [super init];
    if (self) {
        self.method = BBGHttpMethodPost;
    }
    
    return self;
}

- (void)buildParameters:(BBGMutableParameters*)parameters {
    NSMutableDictionary *commentDic = [NSMutableDictionary dictionary];
    [commentDic DICT_SET_VK(_comment,@"comment")];
    [commentDic DICT_SET_VK(_goodsId,@"goodsId")];
    [commentDic DICT_SET_VK(_orderId,@"orderId")];
    [commentDic DICT_SET_VK([_imgArray componentsJoinedByString:@","],@"goodsImgKeys")];

    [parameters addParameter:commentDic forKey:@"comment"];

    [super buildParameters:parameters];
}

- (BOOL)needTimestamp {
    return YES;
}

- (BOOL)needAuthUser {
    
    return YES;
}

- (Class)responseClass {
    return [BBGEvaluateResponse class];
}

@end