//
//  BBGLoginResponse.m
//  Common
//
//  Created by Damon on 15/4/7.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGLoginResponse.h"
@implementation BBGLoginResponse
- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format{
    self = [super initWithData:data format:format];
    if (self) {
//        if (self.isError) {
//            return self;
//        }
        BBGResponseData * data;
        
        DATA_FOR_KEY(data, @"data")
        
        BBGUserInfo * userinfo = [[BBGUserInfo alloc] initWithHandler:self responseData:self.responseData];
        self.userInfo = userinfo;
        
        BOOL_FOR_KEY_DATA(self.requireCaptcha, @"requireCaptcha", data);
        
        STRING_FOR_KEY_DATA(self.message, @"msg", self.responseData)
        
    }
    return self;
}

@end
