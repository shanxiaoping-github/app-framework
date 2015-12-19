//
//  BBGEditAddressReqeust.m
//  Common
//
//  Created by yangjie on 15/5/4.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGEditAddressReqeust.h"
#import "Common.h"

@implementation BBGEditAddressReqeust

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.method = BBGHttpMethodPost;
    }
    return self;
}

- (void)buildParameters:(BBGMutableParameters *)parameters {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict DICT_SET_VK(_addrId, @"addrId")];
    [dict DICT_SET_VK(_reaId, @"id")];
    [dict DICT_SET_VK(_addr,@"addr")];
    [dict DICT_SET_VK(_areaInfo,@"areaInfo")];
    [dict DICT_SET_VK(_mobile,@"mobile")];
    [dict DICT_SET_VK(_name,@"name")];
    [dict DICT_SET_VK(_realName,@"realName")];
    [dict DICT_SET_VK(_idCard,@"idCard")];
    [dict DICT_SET_VK(_defAddr?@"true":@"false",@"defAddr")];
    [dict DICT_SET_VK(_frontImg,@"frontImg")];
    [dict DICT_SET_VK(_backPhotoId,@"reverseImg")];

    [parameters addParameter:dict forKey:@"addr"];
    [super buildParameters:parameters];
}

- (BOOL)needAuthUser {
    
    return YES;
}

- (Class)responseClass{
    return [BBGEditAddressResponse class];
}


@end
