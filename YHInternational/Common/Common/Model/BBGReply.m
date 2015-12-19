//
//  BBGReply.m
//  Common
//
//  Created by Holyjoy on 15/4/29.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGReply.h"

@implementation BBGReply

- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        
        STRING_FOR_KEY(_replyId, @"commentId")
        STRING_FOR_KEY(_replyText, @"comment")
        STRING_FOR_KEY(_isAnonymous, @"isAnonymous")
        STRING_FOR_KEY(_memberId, @"memberId")
        
        NSString *replyDate = [NSString string];
        STRING_FOR_KEY(replyDate, @"commentDisTime")
        _replyTime = [NSString stringWithFormat:@"%@前",replyDate];
        
        BOOL_FOR_KEY(_isESC, @"customerService")

        STRING_FOR_KEY(_memberName, @"memberName")
        STRING_FOR_KEY(_nickName, @"nickName")
        STRING_FOR_KEY(_profileImgUrl, @"profileImgUrl")
        STRING_FOR_KEY(_hasOrder, @"hasOrder")
        BBGResponseData *imgListData;
        DATA_FOR_KEY(imgListData, @"imgUrlList")
        _imgUrlListArray = [NSMutableArray array];

        if ([imgListData count] > 0) {
            for (int i = 0; i < [imgListData count]; i++) {
                NSString *imgUrl = nil;
                STRING_FOR_INDEX_DATA(imgUrl, i, imgListData)
                [_imgUrlListArray addObject:imgUrl];
            }
        }
        
        BBGResponseData *imgHDListData;
        DATA_FOR_KEY(imgHDListData, @"imgUrlHDList")
        _imgHdUrlListArray = [NSMutableArray array];

        if ([imgHDListData count] > 0) {
            for (int i = 0; i < [imgHDListData count]; i++) {
                NSString *imgHdUrl = [NSString string];
                STRING_FOR_INDEX_DATA(imgHdUrl, i, imgHDListData)
                [_imgHdUrlListArray addObject:imgHdUrl];
            }
        }
    }
    return self;
}

@end
