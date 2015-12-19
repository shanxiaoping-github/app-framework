//
//  BBGAddress.m
//  Common
//
//  Created by Timmy Ouyang on 15/4/27.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGAddress.h"

@implementation BBGAddress

- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        STRING_FOR_KEY(self.addrId, @"addrId")
        STRING_FOR_KEY(self.addr,@"addr")
        STRING_FOR_KEY(self.areaInfo, @"areaInfo")
        BOOL_FOR_KEY(self.defAddr, @"defAddr")
        STRING_FOR_KEY(self.frontImg, @"frontImg")
        STRING_FOR_KEY(self.frontImgUrl, @"frontImgUrl")
        STRING_FOR_KEY(self.frontImgUrlHD, @"frontImgUrlHD")
        STRING_FOR_KEY(self.reaId, @"id")
        STRING_FOR_KEY(self.memberId, @"memberId")
        STRING_FOR_KEY(self.idCard, @"idCard")
        STRING_FOR_KEY(self.mobile, @"mobile")
        STRING_FOR_KEY(self.name, @"name")
        STRING_FOR_KEY(self.realName, @"realName")
        STRING_FOR_KEY(self.reverseImg, @"reverseImg")
        STRING_FOR_KEY(self.reverseImgUrl, @"reverseImgUrl")
        STRING_FOR_KEY(self.reverseImgUrlHD, @"reverseImgUrlHD")
        STRING_FOR_KEY(self.tel, @"tel")
        BOOL_FOR_KEY(self.selected, @"selected")
        BOOL_FOR_KEY(self.needEdit, @"needEdit")
    }
    return self;
}
@end
