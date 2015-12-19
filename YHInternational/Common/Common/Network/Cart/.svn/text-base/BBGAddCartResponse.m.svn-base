//
//  BBGAddCartResponse.m
//  Common
//
//  Created by yangjie on 15/5/14.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGAddCartResponse.h"
#import "BBGCartManager.h"

@implementation BBGAddCartResponse

- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format{
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
        
        BBGResponseData *data;
        DATA_FOR_KEY(data, @"data");
        NSInteger totalType;
        INTEGER_FOR_KEY_DATA(totalType, @"totalType", data);
        
        [BBGCartManager sharedInstance].cartCount = @(totalType);
    }
    return self;
}

@end
