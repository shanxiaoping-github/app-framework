//
//  BBGCommentedGoods.m
//  Common
//
//  Created by Holyjoy on 15/4/29.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGCommentedGoods.h"
#import "BBGComment.h"

@implementation BBGCommentedGoods
- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        
        STRING_FOR_KEY(_goodsId, @"goodsId")
        STRING_FOR_KEY(_goodsName, @"goodsName")
        STRING_FOR_KEY(_goodsImgUrl, @"goodsImgUrl")
        STRING_FOR_KEY(_goodsDesc, @"goodsDesc")
        NSInteger price = 0;
        INTEGER_FOR_KEY(price, @"goodsPrice")
        _goodsPrice = [NSString stringWithFormat:@"%.2f",price/100.0];
        
        BBGResponseData *listData;
        DATA_FOR_KEY(listData, @"commentList")
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
