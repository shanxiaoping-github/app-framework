//
//  BBGOrderProduct.h
//  Common
//
//  Created by elvis.peng on 15-5-13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGResponseDataHandler.h"

@interface BBGOrderProduct : BBGResponseDataHandler
@property (nonatomic,strong)NSString *itemId;
@property (nonatomic,strong)NSString *orderId;
@property (nonatomic,strong)NSString *productId;
@property (nonatomic,strong)NSString *goodsId;
@property (nonatomic,strong)NSString *bn;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,assign)float salePrice;
@property (nonatomic,assign)float bargainPrice;
@property (nonatomic,assign)float weight;
@property (nonatomic,assign)NSInteger buyNum;
@property (nonatomic,assign)NSInteger sendNum;
@property (nonatomic,assign)float payAmount;
@property (nonatomic,strong)NSString *itemType;
@property (nonatomic,strong)NSString *imageUrl;

@property (nonatomic,strong)NSString *mkPrice;

@property (nonatomic,assign)float unCrossedPrice;
@property (nonatomic,assign)float crossedPrice;
/**
 *  商品规格
 */
@property (nonatomic,strong)NSString *specText;
@end
