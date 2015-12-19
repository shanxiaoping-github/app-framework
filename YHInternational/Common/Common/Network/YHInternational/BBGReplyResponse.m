//
//  BBGReplyResponse.m
//  Common
//
//  Created by Holyjoy on 15/4/30.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGReplyResponse.h"

@implementation BBGReplyResponse

- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format {
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
        
        _sucessful = YES;
    }
    return self;
}


@end
