//
//  BBGRongResponse.m
//  Common
//
//  Created by Damon on 15/7/13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGRongResponse.h"

@implementation BBGRongResponse
- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format{
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
        BBGResponseData * detailData;
        DATA_FOR_KEY(detailData, @"data")
        BBGResponseData * result;
        DATA_FOR_KEY_DATA(result, @"result", detailData)
        BBGResponseData * resultData;
        resultData = [[BBGResponseData alloc] initWithData:result.data];
        NSString * str = resultData.stringValue;
        NSArray * array = [str componentsSeparatedByString:@"\""];
        self.rongToken = array[array.count - 2];
    }
    return self;
}
@end
