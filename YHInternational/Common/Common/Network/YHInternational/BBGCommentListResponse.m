//
//  BBGCommentListResponse.m
//  Common
//
//  Created by Holyjoy on 15/4/23.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGCommentListResponse.h"
#import "BBGCommentedGoods.h"

@implementation BBGCommentListResponse

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
    

        if ([listData count]) {
            _commentedGoodsList = [[NSMutableArray alloc] init];

            for (int i = 0; i < [listData count]; i++) {
                BBGResponseData *commentedGoodData;
                DATA_FOR_INDEX_DATA(commentedGoodData, i, listData)
                
                BBGCommentedGoods *commentedGoods = [[BBGCommentedGoods alloc] initWithHandler:self responseData:commentedGoodData];
                [_commentedGoodsList addObject:commentedGoods];
            }
            
        }
        
        
    }
    return self;
}


@end
