//
//  BBGUserHeader.m
//  Common
//
//  Created by yangjie on 15/4/29.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGUserHeader.h"

@implementation BBGUserHeader

- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        STRING_FOR_KEY(self.imageId,@"id")
        STRING_FOR_KEY(self.imageUrl,@"url")

    }
    return self;
}
@end
