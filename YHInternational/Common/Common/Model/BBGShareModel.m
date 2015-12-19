//
//  BBGShareModel.m
//  Common
//
//  Created by 彭腾 on 15/5/20.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGShareModel.h"

@implementation BBGShareModel

- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData{
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        STRING_FOR_KEY(_actId, @"actId")
        STRING_FOR_KEY(_packetId, @"packetId")
        STRING_FOR_KEY(_shareUrl, @"shareUrl")
        STRING_FOR_KEY(_ad, @"ad")
        STRING_FOR_KEY(_shareTitle, @"shareTitle")
        STRING_FOR_KEY(_shareContent, @"shareContent")
        STRING_FOR_KEY(_overTime, @"overTime")

    }
    return self;
}

@end
