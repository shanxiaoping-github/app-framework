//
//  BBGModifyIDCardResponse.m
//  Common
//
//  Created by holyjoy on 15/3/5.
//  Copyright (c) 2015年 BuBuGao. All rights reserved.
//

#import "BBGModifyIDCardResponse.h"

@implementation BBGModifyIDCardResponse

- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format {
    self = [super initWithData:data format:format];
    
    if (self) {
        if (self.isError) {
            return self;
        }
    }
    return self;
}

@end
