//
//  BBGCheckCartResponse.m
//  Common
//
//  Created by yangjie on 15/5/16.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGCheckCartResponse.h"
#import "BBGCartManager.h"

@implementation BBGCheckCartResponse

- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format{
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
        
        BBGProductsCart *productsCart = [[BBGProductsCart alloc] initWithHandler:self responseData:self.responseData];
        self.productsCart = productsCart;
    }
    return self;
}

@end
