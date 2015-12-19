//
//  BBGSubAttribute.m
//  Common
//
//  Created by calvin on 14-8-6.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import "BBGSubAttribute.h"

@implementation BBGSubAttribute

- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        STRING_FOR_KEY(self.subAttributeID, @"id")
        STRING_FOR_KEY(self.subAttributeName, @"name")
        STRING_FOR_KEY(self.attributeName, @"name")
    }
    return self;
}

@end
