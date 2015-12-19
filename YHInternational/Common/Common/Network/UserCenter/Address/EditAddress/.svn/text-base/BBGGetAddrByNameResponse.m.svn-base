//
//  BBGGetAddrByNameResponse.m
//  Common
//
//  Created by yangjie on 15/5/6.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGetAddrByNameResponse.h"

@implementation BBGGetAddrByNameResponse
- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format {
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
        
        BBGResponseData *IDCardData;
        DATA_FOR_KEY(IDCardData, @"data")
        STRING_FOR_KEY_DATA(_IDCard, @"idCard",IDCardData)
        STRING_FOR_KEY_DATA(_IDCardPhotoFrontUrl, @"frontImgUrl",IDCardData)
        STRING_FOR_KEY_DATA(_IDCardPhotoBackUrl, @"reverseImgUrl",IDCardData)
        STRING_FOR_KEY_DATA(_IDCardPhotoFrontUrlHD, @"frontImgUrlHD",IDCardData)
        STRING_FOR_KEY_DATA(_IDCardPhotoBackUrlHD, @"reverseImgUrlHD",IDCardData)
        STRING_FOR_KEY_DATA(_IDCardPhotoFrontImageId, @"frontImg",IDCardData)
        STRING_FOR_KEY_DATA(_IDCardPhotoBackImageId, @"reverseImg",IDCardData)
    }
    return self;
}

@end
