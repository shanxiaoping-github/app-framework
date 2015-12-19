//
//  BBGCartRemoveResponse.m
//  Common
//
//  Created by yangjie on 15/5/18.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGCartRemoveResponse.h"
#import "BBGCartManager.h"

@implementation BBGCartRemoveResponse

- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format{
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
        
        BBGProductsCart *productsCart = [[BBGProductsCart alloc] initWithHandler:self responseData:self.responseData];
        self.productsCart = productsCart;
    
        [[BBGCartManager sharedInstance] updateCartData];
    }
    return self;
}

@end
