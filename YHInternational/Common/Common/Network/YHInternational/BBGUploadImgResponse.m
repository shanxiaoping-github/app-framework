//
//  BBGUploadImgResponse.m
//  Common
//
//  Created by yangjie on 15/5/19.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGUploadImgResponse.h"

@implementation BBGUploadImgResponse

- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format{
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
        BBGResponseData *data;
        DATA_FOR_KEY(data, @"data")
        
        BBGImgModel *model = [[BBGImgModel alloc] initWithHandler:self responseData:data];
        self.imgModel = model;
    }
    return self;
}

@end
