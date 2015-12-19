//
//  BBGUpdateCartResponse.h
//  Common
//
//  Created by yangjie on 15/5/16.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGResponse.h"
#import "BBGProductsCart.h"

@interface BBGUpdateCartResponse : BBGResponse

@property (nonatomic,strong)BBGProductsCart *productsCart;

@end
