//
//  BBGCheckCartRequest.h
//  Common
//
//  Created by yangjie on 15/5/16.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGRequest.h"

@interface BBGCheckCartRequest : BBGRequest

/**
 *  货品编号
 */
@property (nonatomic,strong) NSArray *productIds;

@end
