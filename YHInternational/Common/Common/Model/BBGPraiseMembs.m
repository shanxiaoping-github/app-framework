//
//  BBGPraiseMembs.m
//  Common
//
//  Created by 彭腾 on 15-5-7.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGPraiseMembs.h"

@implementation BBGPraiseMembs

- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData] ;
    if (self) {
        if (self.isError) {
            return self ;
        }
        STRING_FOR_KEY(_memberHeadUrl, @"memberHeadUrl")
        STRING_FOR_KEY(_memberId, @"memberId")
        STRING_FOR_KEY(_memberName, @"memberName")
        STRING_FOR_KEY(_productId, @"productId")
    }
    return self ;
}

@end
