//
//  BBGIDCardListResponse.m
//  Common
//
//  Created by holyjoy on 15/3/4.
//  Copyright (c) 2015年 BuBuGao. All rights reserved.
//

#import "BBGIDCardListResponse.h"

@implementation BBGIDCardListResponse
- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format {
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
        BBGResponseData *IDCardData;
        DATA_FOR_KEY(IDCardData, @"data")
        NSInteger IDCardCount = [IDCardData count];
        NSMutableArray *IDCardList = [NSMutableArray arrayWithCapacity:IDCardCount];
        for (int i = 0; i < IDCardCount; i ++) {
            BBGResponseData *IDCard;
            DATA_FOR_INDEX_DATA(IDCard, i, IDCardData)
            BBGIDCard *userIDCard = [[BBGIDCard alloc] initWithHandler:self responseData:IDCard];
            [IDCardList addObject:userIDCard];
        }
        self.userIDCardList = IDCardList;
    }
    return self;
}

@end
