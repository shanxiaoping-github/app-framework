//
//  BBGUpdateCartRequest.h
//  Common
//
//  Created by yangjie on 15/5/16.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGRequest.h"

@interface BBGUpdateCartRequest : BBGRequest

/**
 *  货品编号
 */
@property (nonatomic,strong) NSString *productId;

/**
 *  数量
 */
@property (nonatomic,assign) NSInteger quantity;

@end
