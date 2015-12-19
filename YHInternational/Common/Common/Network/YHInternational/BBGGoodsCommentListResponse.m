//
//  BBGGoodsCommentListResponse.m
//  Common
//
//  Created by Holyjoy on 15/5/6.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGoodsCommentListResponse.h"
#import "BBGComment.h"

@implementation BBGGoodsCommentListResponse
- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format {
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
        BBGResponseData * data1;
        DATA_FOR_KEY(data1, @"data")
        
        INTEGER_FOR_KEY_DATA(_size, @"size", data1)
        INTEGER_FOR_KEY_DATA(_count, @"count", data1)
        INTEGER_FOR_KEY_DATA(_pageNumber, @"pageNumber", data1)
        
        BBGResponseData * listData;
        DATA_FOR_KEY_DATA(listData, @"data",data1)
        
        if ([listData count] > 0) {
            
            _commentList = [NSMutableArray array];
            for (int i = 0; i < [listData count]; i++) {
                BBGResponseData *commentData;
                DATA_FOR_INDEX_DATA(commentData, i, listData)
                
                BBGComment *comment = [[BBGComment alloc] initWithHandler:self responseData:commentData];
                [_commentList addObject:comment];
            }
        }
        
    }
    return self;
}

@end
