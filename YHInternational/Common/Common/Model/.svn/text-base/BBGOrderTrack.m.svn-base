//
//  BBGOrderTrack.m
//  Common
//
//  Created by elvis.peng on 15-5-14.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGOrderTrack.h"

@implementation BBGOrderTrack
- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        STRING_FOR_KEY(self.type, @"type")
        STRING_FOR_KEY(self.trackInfo, @"info")
        TIMESTAMP_FOR_KEY(self.trackTime, @"operateTime")
    }
    return self;
}
@end
