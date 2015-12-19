//
//  BBGIndexRecomendInitInfo.m
//  Common
//
//  Created by 黄 灿 on 15/8/25.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGIndexRecomendInitInfo.h"

@implementation BBGIndexRecomendInitInfo
-(id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData{
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        STRING_FOR_KEY(self.Id, @"id")
        STRING_FOR_KEY(self.Name, @"name")
        STRING_FOR_KEY(self.img, @"img")
        STRING_FOR_KEY(self.sort, @"sort")
        STRING_FOR_KEY(self.url, @"url")
        STRING_FOR_KEY(self.btnId, @"btnId")
    }
    return self;

}
@end
