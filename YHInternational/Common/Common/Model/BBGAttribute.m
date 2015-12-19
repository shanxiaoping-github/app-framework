//
//  BBGAttribute.m
//  Common
//
//  Created by calvin on 14-8-6.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import "BBGAttribute.h"
#import "BBGSubAttribute.h"

@implementation BBGAttribute

- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        STRING_FOR_KEY(self.attributeID, @"propsId")
        STRING_FOR_KEY(self.attributeName, @"propsName")
        BBGResponseData *subAttributesData;
        DATA_FOR_KEY(subAttributesData, @"propsValues")
        NSInteger subAttributeCount = [subAttributesData count];
        NSMutableArray *subAttributes = [NSMutableArray arrayWithCapacity:subAttributeCount];
        for (int i = 0; i < subAttributeCount; i ++) {
            BBGResponseData *subAttributeData;
            DATA_FOR_INDEX_DATA(subAttributeData, i, subAttributesData)
            BBGSubAttribute *subAttribute = [[BBGSubAttribute alloc] initWithHandler:self responseData:subAttributeData];
            [subAttributes addObject:subAttribute];
        }
        self.subAttributes = subAttributes;
    }
    return self;
}

@end
