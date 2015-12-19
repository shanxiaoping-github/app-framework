//
//  BBGGSFastModel.m
//  Common
//
//  Created by 彭腾 on 15/10/22.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGSFastModel.h"

@implementation BBGGSFastModel

- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        STRING_FOR_KEY(self.createtime, @"createtime");
        STRING_FOR_KEY(self.orderId, @"orderId");
    }
    return self;
}


@end
