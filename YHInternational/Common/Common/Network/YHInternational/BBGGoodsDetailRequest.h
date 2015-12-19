//
//  BBGGoodsDetailRequest.h
//  Common
//
//  Created by 彭腾 on 15-5-6.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGRequest.h"

@interface BBGGoodsDetailRequest : BBGRequest

@property (nonatomic, copy) NSString *barCode ;

@property (nonatomic, copy) NSString *bn ;

@property (nonatomic, copy) NSString *city ;

@property (nonatomic, assign) NSInteger commentPageSize ;

@property (nonatomic, assign) NSInteger praisePageSize ;

@property (nonatomic, copy) NSString *productId ;

@property (nonatomic, copy) NSString *provine ;

@property (nonatomic, copy) NSString *shopId ;

@property (nonatomic, copy) NSString *township ;

@property (nonatomic, copy) NSString *goodsId ;

@end
