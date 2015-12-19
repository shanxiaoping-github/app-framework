//
//  BBGIndexUpdateIOSResponse.m
//  Common
//
//  Created by yangjie on 15/10/24.
//  Copyright © 2015年 Bubugao. All rights reserved.
//

#import "BBGIndexUpdateIOSResponse.h"

@implementation BBGIndexUpdateIOSResponse

- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format {
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
        BBGResponseData *responseData;
        DATA_FOR_KEY(responseData, @"data")
        
        STRING_FOR_KEY_DATA(_bbgScript, @"bbgScript", responseData);
    }
    return self;
}

@end
