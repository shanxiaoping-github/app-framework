//
//  BBGImgModel.m
//  Common
//
//  Created by yangjie on 15/5/20.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGImgModel.h"

@implementation BBGImgModel
- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        BBGResponseData *data;
        DATA_FOR_INDEX_DATA(data, 0, responseData);
        STRING_FOR_KEY_DATA(self.imgBase64Str, @"image_base64_str",data)
        STRING_FOR_KEY_DATA(self.imgId, @"id", data);
        STRING_FOR_KEY_DATA(self.url, @"url", data)
    }
    return self;
}

@end
