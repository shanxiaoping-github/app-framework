//
//  BBGRegisterResponse.m
//  Common
//
//  Created by Damon on 15/4/27.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGRegisterResponse.h"

@implementation BBGRegisterResponse

- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format{
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
        BBGResponseData * resData;
        DATA_FOR_KEY(resData, @"data")
        
        STRING_FOR_KEY_DATA(self.sessionId, @"sessionId", resData)
        STRING_FOR_KEY_DATA(self.memberId, @"memberId", resData)
        DOUBLE_FOR_KEY_DATA(self.regTime, @"regTime", resData)
        STRING_FOR_KEY_DATA(self.email, @"email", resData)
        STRING_FOR_KEY_DATA(self.regIp, @"regIp", resData)
        
        STRING_FOR_KEY_DATA(self.captchaImageUrl,@"captchaImageUrl", resData)
        BOOL_FOR_KEY_DATA(self.result, @"result", resData)
        STRING_FOR_KEY_DATA(self.message, @"message", resData)
        
    }
    return self;
}

@end
