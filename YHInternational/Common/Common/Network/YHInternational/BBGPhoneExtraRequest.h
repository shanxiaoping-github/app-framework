//
//  BBGPhoneExtraRequest.h
//  Common
//
//  Created by Timmy OuYang on 15/5/22.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGRequest.h"
#import "BBGSearchRequest.h"

@interface BBGPhoneExtraRequest : BBGRequest

/**
 *  只显示有货商品，YES表示只显示有货，NO表示显示所有
 */
@property (nonatomic, assign) BOOL hasStore;
/**
 *  页码，默认为1
 */
@property (nonatomic, assign) NSUInteger page;
/**
 *  每页商品数，默认为20
 */
@property (nonatomic, assign) NSUInteger pageSize;
/**
 *  商品列表的排序类型
 */
@property (nonatomic, assign) SortType type;

@end
