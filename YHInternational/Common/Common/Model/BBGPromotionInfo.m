//
//  BBGPromotionInfo.m
//  Common
//
//  Created by 彭腾 on 15/8/5.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGPromotionInfo.h"

@implementation BBGPromotionInfo

- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData] ;
    if (self) {
        if (self.isError) {
            return self ;
        }
        INTEGER_FOR_KEY(_canBuyNum, @"canBuyNum")
        INTEGER_FOR_KEY(_numPerMember, @"numPerMember")
        INTEGER_FOR_KEY(_realNum, @"realNum")
        INTEGER_FOR_KEY(_limitType, @"limitType")
        INTEGER_FOR_KEY(_limitValue, @"limitValue")
        INTEGER_FOR_KEY(_realValue, @"realValue")
        INTEGER_FOR_KEY(_kindPerMemberOrder, @"kindPerMemberOrder")
    }
    return self ;
}

@end
