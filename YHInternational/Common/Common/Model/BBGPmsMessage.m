//
//  BBGPmsMessage.m
//  Common
//
//  Created by elvis.peng on 15-5-19.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGPmsMessage.h"

@implementation BBGPmsMessage
- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        STRING_FOR_KEY(self.pmsId, @"id")
        STRING_FOR_KEY(self.message, @"info")
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        DATETIME_FOR_KEY(self.begintime, @"begintime", formatter)
        DATETIME_FOR_KEY(self.endtime, @"endtime", formatter)
        STRING_FOR_KEY(self.type, @"type")
    }
    return self;
}
@end
