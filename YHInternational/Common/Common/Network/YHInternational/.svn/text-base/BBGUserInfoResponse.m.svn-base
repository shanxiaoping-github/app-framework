//
//  BBGUserInfoResponse.m
//  Common
//
//  Created by BubuGao on 15-4-23.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGUserInfoResponse.h"
#import "BBGSession.h"

@implementation BBGUserInfoResponse

- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format{
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
        
        BBGUserDetailInfo * userDetailinfo = [[BBGUserDetailInfo alloc] initWithHandler:self responseData:self.responseData];
        self.userDetailInfo = userDetailinfo;
        
        [BBGSession sharedInstance].userDetailInfo  = userDetailinfo;

    }
    return self;
}

@end
