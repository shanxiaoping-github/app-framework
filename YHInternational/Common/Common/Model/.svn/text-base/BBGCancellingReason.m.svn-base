//
//  BBGCancellingReason.m
//  Common
//
//  Created by calvin on 14-8-13.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import "BBGCancellingReason.h"

@implementation BBGCancellingReason

- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        STRING_FOR_KEY(self.reasonID, @"id")
        STRING_FOR_KEY(self.reason, @"reason")
    }
    return self;
}

@end
