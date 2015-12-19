//
//  BBGGoodsSpecRequest.h
//  Common
//
//  Created by 彭腾 on 15-5-14.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGRequest.h"

@interface BBGGoodsSpecRequest : BBGRequest

//商品ID
@property (nonatomic, copy) NSString *goodsId ;
//规格条件 形式: 规格名1id:规格值1id;规格名2id:规格值2id;如果为空则所有规格都可以选
@property (nonatomic, copy) NSString *filterText ;
//省
@property (nonatomic, copy) NSString *provine ;
//市
@property (nonatomic, copy) NSString *city ;
//县
@property (nonatomic, copy) NSString *township ;

@end
