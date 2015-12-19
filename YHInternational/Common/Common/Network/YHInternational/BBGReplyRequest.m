//
//  BBGReplyRequest.m
//  Common
//
//  Created by Holyjoy on 15/4/30.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGReplyRequest.h"
#import "BBGReplyResponse.h"
#import "Common.h"

@implementation BBGReplyRequest
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
    [commentDic DICT_SET_VK(_contact,@"contact")];
    [commentDic DICT_SET_VK(_forCommentId,@"forCommentId")];
    [commentDic DICT_SET_VK(_goodsId,@"goodsId")];
    [commentDic DICT_SET_VK(_goodsImgKeys,@"goodsImgKeys")];
    [commentDic DICT_SET_VK(_ip,@"ip")];
    [commentDic DICT_SET_VK(_isAnonymous,@"isAnonymous")];
    [commentDic DICT_SET_VK(_memberName,@"memberName")];
    [commentDic DICT_SET_VK(_memberId,@"memberId")];
    [commentDic DICT_SET_VK(_orderId,@"orderId")];

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
    return [BBGReplyResponse class];
}
@end
