//
//  BBGGetCommentDetailResponse.m
//  Common
//
//  Created by yangjie on 15/5/22.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGetCommentDetailResponse.h"

@implementation BBGGetCommentDetailResponse
- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format {
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
        
        BBGResponseData *responseData;
        DATA_FOR_KEY(responseData, @"data")
        INTEGER_FOR_KEY_DATA(self.countsForShareOrder, @"countsForShareOrder", responseData)
        
    }
    return self;
}
@end
