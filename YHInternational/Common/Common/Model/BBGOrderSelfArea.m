//
//  BBGOrderSelfArea.m
//  Common
//
//  Created by elvis.peng on 15-5-13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGOrderSelfArea.h"

@implementation BBGOrderSelfArea
- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData] ;
    if (self) {
        if (self.isError) {
            return self ;
        }
        
        STRING_FOR_KEY(self.orderId, @"orderId")
        STRING_FOR_KEY(self.selfId, @"selfId")
        STRING_FOR_KEY(self.regionId, @"regionId")
        STRING_FOR_KEY(self.name, @"name")
        STRING_FOR_KEY(self.address, @"address")
        STRING_FOR_KEY(self.tel, @"tel")
        STRING_FOR_KEY(self.username, @"username")
        
    }
    return self;
}
@end
