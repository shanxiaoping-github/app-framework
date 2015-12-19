//
//  BBGPayType.m
//  Common
//
//  Created by elvis.peng on 15-5-15.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGPayType.h"

@implementation BBGPayType
- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        STRING_FOR_KEY(self.payCode, @"code")
        STRING_FOR_KEY(self.payName, @"name")
        STRING_FOR_KEY(self.iconUrl, @"iconUrl")
    }
    return self;
}
@end
