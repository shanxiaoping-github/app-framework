//
//  BBGUnEvaluateRequest.h
//  Common
//
//  Created by Holyjoy on 15/5/19.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGRequest.h"

@interface BBGUnEvaluateRequest : BBGRequest

/**
 *  页码，默认为1
 */
@property (nonatomic, assign) NSInteger pageIndex;
/**
 *  每页商品数，默认为20
 */
@property (nonatomic, assign) NSInteger pageSize;
@end
