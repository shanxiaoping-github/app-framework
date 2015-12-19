//
//  BBGComment.m
//  Common
//
//  Created by Holyjoy on 15/4/23.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGComment.h"

@implementation BBGComment

- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        
        STRING_FOR_KEY(_commentId, @"commentId")
        STRING_FOR_KEY(_commentText, @"comment")
        STRING_FOR_KEY(_contact, @"contact")
        STRING_FOR_KEY(_isAnonymous, @"isAnonymous")
        STRING_FOR_KEY(_memberId, @"memberId")
        STRING_FOR_KEY(_hasOrder, @"hasOrder")
        STRING_FOR_KEY(_profileImgUrl, @"profileImgUrl")
        BOOL_FOR_KEY(_isESC, @"customerService")
        NSString *commentDate = [NSString string];
        STRING_FOR_KEY(commentDate, @"commentTimeDistance")
        _commentTime = [NSString stringWithFormat:@"%@前",commentDate];
        
        STRING_FOR_KEY(_memberName, @"memberName")
        STRING_FOR_KEY(_nickName, @"nickName")
        
        BBGResponseData *imgListData;
        DATA_FOR_KEY(imgListData, @"imgUrlList")
        _imgUrlListArray = [NSMutableArray array];
        if ([imgListData count] > 0) {
            for (int i = 0; i < [imgListData count]; i++) {
                NSString *imgUrl = [NSString string];
                STRING_FOR_INDEX_DATA(imgUrl, i, imgListData)
                [_imgUrlListArray addObject:imgUrl];
            }
        }
//        NSString *imgUrl = @"http://img04.bubugao.com/150a71943e8_c7_c4c3d400369efd130d39e3de9c6fece3_540x540.jpeg!m1";
//        [_imgUrlListArray addObject:imgUrl];
        
        
        BBGResponseData *imgHDListData;
        DATA_FOR_KEY(imgHDListData, @"imgUrlHDList")
        _imgHdUrlListArray = [NSMutableArray array];
//        NSString *imgUrl1 = @"http://img04.bubugao.com/150a71943e8_c7_c4c3d400369efd130d39e3de9c6fece3_540x540.jpeg!m1";
//        [_imgHdUrlListArray addObject:imgUrl1];
        

        if ([imgHDListData count] > 0) {
            for (int i = 0; i < [imgHDListData count]; i++) {
                NSString *imgHdUrl = [NSString string];
                STRING_FOR_INDEX_DATA(imgHdUrl, i, imgHDListData)
                [_imgHdUrlListArray addObject:imgHdUrl];
            }
        }

        
        BBGResponseData *replyData;
        DATA_FOR_KEY(replyData, @"replyFor")
        
        if (replyData) {

           _replyFor = [[BBGReply alloc] initWithHandler:self responseData:replyData];
        }
    }
    return self;
}

@end
