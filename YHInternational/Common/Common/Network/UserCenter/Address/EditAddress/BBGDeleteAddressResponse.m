//
//  BBGDeleteAddressResponse.m
//  Common
//
//  Created by yangjie on 15/5/5.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGDeleteAddressResponse.h"

@implementation BBGDeleteAddressResponse
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
