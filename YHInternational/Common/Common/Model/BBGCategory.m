//
//  BBGCategory.m
//  Common
//
//  Created by Timmy Ouyang on 15/5/5.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGCategory.h"

@implementation BBGCategory

- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        STRING_FOR_KEY(self.catId, @"id")
        STRING_FOR_KEY(self.name, @"name")
        INTEGER_FOR_KEY(self.count, @"count")
        FLOAT_FOR_KEY(self.minPrice, @"left")
        FLOAT_FOR_KEY(self.maxPrice, @"right")
        BOOL_FOR_KEY(self.isSelected, @"checked")
        BOOL_FOR_KEY(self.isExpanded, @"isExpanded")
    }
    return self;
}

@end
