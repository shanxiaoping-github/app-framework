//
//  BBGUserInfo.m
//  Common
//
//  Created by Damon on 15/4/22.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGUserInfo.h"

@implementation BBGUserInfo
- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        BBGResponseData * data;
        DATA_FOR_KEY(data, @"data")
        
        
        STRING_FOR_KEY_DATA(self.memberId, @"memberId", data)
        
        
        STRING_FOR_KEY_DATA(self.accessToken, @"accessToken", data)
        
        STRING_FOR_KEY_DATA(self.userSecret, @"secret", data)
        
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.memberId = [aDecoder decodeObjectForKey:@"memberId"];
        
        self.accessToken = [aDecoder decodeObjectForKey:@"accessToken"];
        
        self.userSecret = [aDecoder decodeObjectForKey:@"secret"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.memberId forKey:@"memberId"];
    [aCoder encodeObject:self.accessToken forKey:@"accessToken"];
    [aCoder encodeObject:self.userSecret forKey:@"secret"];
}

- (void)dealloc{
    self.memberId = nil;
    self.accessToken = nil;
    self.userSecret = nil;
}

@end