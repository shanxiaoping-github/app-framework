//
//  BBGIDCard.m
//  Common
//
//  Created by Holyjoy on 15/3/4.
//  Copyright (c) 2015年 BuBuGao. All rights reserved.
//

#import "BBGIDCard.h"

@implementation BBGIDCard

- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData{
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        STRING_FOR_KEY(self.IDName, @"realName")
        STRING_FOR_KEY(self.mIDNumber, @"idCard")
        STRING_FOR_KEY(self.IDNumber, @"privateIdCard")
        INTEGER_FOR_KEY(self.IDCardId, @"id")
        STRING_FOR_KEY(self.frontImgUrl, @"frontImgUrl")
        STRING_FOR_KEY(self.reverseImgUrl, @"reverseImgUrl")
        STRING_FOR_KEY(self.frontImgKey, @"frontImg")
        STRING_FOR_KEY(self.reverseImgKey, @"reverseImg")
        STRING_FOR_KEY(self.frontImgUrlHD, @"frontImgUrlHD")
        STRING_FOR_KEY(self.reverseImgUrlHD, @"reverseImgUrlHD")
        //        BOOL_FOR_KEY(self.selected, @"selected")
        //        BOOL_FOR_KEY(self.disabled, @"disabled")
        //
        //        BOOL_FOR_KEY(self.needEdit, @"needEdit")
        //        STRING_FOR_KEY(self.editReason, @"editReason")
    }
    return self;
}

@end
