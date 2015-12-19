//
//  BBGOrderPmt.m
//  Common
//
//  Created by elvis.peng on 15-5-14.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGOrderPmt.h"

@implementation BBGOrderPmt
- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        STRING_FOR_KEY(self.orderId, @"orderId")
        STRING_FOR_KEY(self.toolLevel, @"toolLevel")
        STRING_FOR_KEY(self.adInfo, @"ad")
        STRING_FOR_KEY(self.discount, @"discount")
        STRING_FOR_KEY(self.pmtId, @"pmtId")
        STRING_FOR_KEY(self.name, @"name")
        STRING_FOR_KEY(self.toolName, @"toolName")
        
    }
    return self;
}
@end
