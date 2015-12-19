//
//  BBGCartGetResponse.h
//  Common
//
//  Created by yangjie on 15/5/12.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGResponse.h"
#import "BBGProductsCart.h"

@interface BBGCartGetResponse : BBGResponse

@property (nonatomic,strong)BBGProductsCart *productsCart;

@end
