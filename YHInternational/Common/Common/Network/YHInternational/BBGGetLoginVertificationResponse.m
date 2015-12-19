//
//  BBGGetLoginVertificationResponse.m
//  Common
//
//  Created by Damon on 15/4/27.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGetLoginVertificationResponse.h"

@implementation BBGGetLoginVertificationResponse

- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format{
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
        BBGResponseData * responseData;
        DATA_FOR_KEY(responseData, @"data")
        
        STRING_FOR_KEY_DATA(self.imageUrl, @"imageUrl", responseData)
        
        
        STRING_FOR_KEY_DATA(self.sessionId, @"sessionId", responseData)
    }
    return self;
}

@end
