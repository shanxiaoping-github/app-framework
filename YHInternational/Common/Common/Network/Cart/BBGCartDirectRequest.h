//
//  BBGCartDirectRequest.h
//  Common
//
//  Created by OuyangTimmy on 15/7/21.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGRequest.h"

@interface BBGCartDirectRequest : BBGRequest

/**
 *  货品编号
 */
@property (nonatomic,strong) NSString *productId;

/**
 *  数量
 */
@property (nonatomic,assign) NSInteger quantity;

@end
