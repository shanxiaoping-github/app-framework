//
//  BBGUploadIDPhotoResponse.m
//  Common
//
//  Created by Holyjoy on 15/6/8.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGUploadIDPhotoResponse.h"

@implementation BBGUploadIDPhotoResponse

- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format{
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
        BBGResponseData *data;
        DATA_FOR_KEY(data, @"data");
        DATA_FOR_INDEX_DATA(data, 0, data)
        BBGUserHeader *userHeader = [[BBGUserHeader alloc] initWithHandler:self responseData:data];
        self.userHeader = userHeader;
        
    }
    return self;
}


@end
