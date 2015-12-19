//
//  BBGOrderAgainPurchaseResponse.m
//  Common
//
//  Created by elvis.peng on 15-5-19.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGOrderAgainPurchaseResponse.h"

@implementation BBGOrderAgainPurchaseResponse
- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format{
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
    }
    return self;
}
@end
