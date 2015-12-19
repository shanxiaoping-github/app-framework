//
//  BBGUserDetailInfo.m
//  Common
//
//  Created by yangjie on 15/4/29.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGUserDetailInfo.h"

@implementation BBGUserDetailInfo

- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData{
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        BBGResponseData * data;
        DATA_FOR_KEY(data, @"data")
        
        INTEGER_FOR_KEY_DATA(self.memberId, @"memberId", data)
        
        STRING_FOR_KEY_DATA(self.nickName, @"nickName", data)
        
        STRING_FOR_KEY_DATA(self.headImg, @"headImg", data)
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.memberId = [aDecoder decodeIntegerForKey:@"memberId"];
        
        self.nickName = [aDecoder decodeObjectForKey:@"nickName"];
        
        self.headImg = [aDecoder decodeObjectForKey:@"headImg"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInteger:self.memberId forKey:@"memberId"];
    [aCoder encodeObject:self.nickName forKey:@"nickName"];
    [aCoder encodeObject:self.headImg forKey:@"headImg"];
}

@end
