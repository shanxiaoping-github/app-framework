//
//  BBGSetUserHeadImgResponse.m
//  Common
//
//  Created by yangjie on 15/4/29.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGSetUserHeadImgResponse.h"
#import "BBGSession.h"

@implementation BBGSetUserHeadImgResponse

- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format{
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
        
        BBGUserDetailInfo * userDetailinfo = [[BBGUserDetailInfo alloc] initWithHandler:self responseData:self.responseData];
        self.userDetailInfo = userDetailinfo;
        [BBGSession sharedInstance].userDetailInfo = userDetailinfo;
    }
    return self;
}

@end
