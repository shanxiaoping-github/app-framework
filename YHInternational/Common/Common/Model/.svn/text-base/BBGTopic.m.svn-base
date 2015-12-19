//
//  BBGTopic.m
//  Common
//
//  Created by Damon on 15/5/21.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGTopic.h"

@implementation BBGTopic
- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData{
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        STRING_FOR_KEY(self.adName, @"adName")
        STRING_FOR_KEY(self.adImgURL, @"adImg")
        STRING_FOR_KEY(self.adURL, @"adUrl")
        INTEGER_FOR_KEY(self.praiseCount, @"praiseCount")
    }
    return self;
}
@end
