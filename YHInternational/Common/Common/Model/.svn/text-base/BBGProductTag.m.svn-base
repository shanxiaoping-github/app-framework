//
//  BBGProductTag.m
//  Common
//
//  Created by 文礼 on 14/11/18.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import "BBGProductTag.h"
#import "BBGMacro.h"

@implementation BBGProductTag
- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        STRING_FOR_KEY(self.tagName, @"labelName")
        NUMBER_FOR_KEY(self.tagId, @"targetId");
        BOOL_FOR_KEY(self.showInView, @"isShow")
        NSInteger locationTag;
        INTEGER_FOR_KEY(locationTag, @"location");
        switch (locationTag) {
            case 3:
                self.location = Tag_Location_Center;
                break;
                
            default:
                self.location = Tag_Location_TopRight;
                break;
        }
        
        CGFloat alpha;
        FLOAT_FOR_KEY(alpha, @"transparency")
        alpha = alpha/10.0;
        NSString *bgColor;
        STRING_FOR_KEY(bgColor, @"bgColor")
        if (bgColor && bgColor.length >= 7) {
            NSUInteger red = strtoul([[bgColor substringWithRange:NSMakeRange(1, 2) ]UTF8String],0,16);
            NSUInteger green = strtoul([[bgColor substringWithRange:NSMakeRange(3, 2) ]UTF8String],0,16);
            NSUInteger blue = strtoul([[bgColor substringWithRange:NSMakeRange(5, 2) ]UTF8String],0,16);
            self.bgColor = UIColorFromRGB(red, green, blue);
        }
        
        STRING_FOR_KEY(bgColor, @"wordColor")
        if (bgColor && bgColor.length >= 7) {
            NSUInteger red = strtoul([[bgColor substringWithRange:NSMakeRange(1, 2) ]UTF8String],0,16);
            NSUInteger green = strtoul([[bgColor substringWithRange:NSMakeRange(3, 2) ]UTF8String],0,16);
            NSUInteger blue = strtoul([[bgColor substringWithRange:NSMakeRange(5, 2) ]UTF8String],0,16);
            self.fontColor = UIColorFromRGB(red, green, blue);
        }
        if (self.bgColor) {
            self.bgColor = [self.bgColor colorWithAlphaComponent:alpha];
        }
    }
    return self;
}
@end
