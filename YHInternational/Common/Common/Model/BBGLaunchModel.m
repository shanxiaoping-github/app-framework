//
//  BBGLaunchModel.m
//  Common
//
//  Created by Damon on 15/5/26.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGLaunchModel.h"

@implementation BBGLaunchModel
- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData{
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        STRING_FOR_KEY(self.adImg, @"img")
        
        DOUBLE_FOR_KEY(self.beginTime, @"beginTime")
        
        DOUBLE_FOR_KEY(self.endTime, @"endTime")
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.image = [aDecoder decodeObjectForKey:@"adImage"];
        self.adImg = [aDecoder decodeObjectForKey:@"img"];
        self.beginTime = [aDecoder decodeDoubleForKey:@"beginTime"];
        self.endTime = [aDecoder decodeDoubleForKey:@"endTime"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.image forKey:@"adImage"];
    [aCoder encodeObject:self.adImg forKey:@"img"];
    [aCoder encodeDouble:self.beginTime forKey:@"beginTime"];
    [aCoder encodeDouble:self.endTime forKey:@"endTime"];
}

@end
