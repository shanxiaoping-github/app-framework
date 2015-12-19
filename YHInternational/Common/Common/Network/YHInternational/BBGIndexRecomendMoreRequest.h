//
//  BBGIndexRecomendMoreRequest.h
//  Common
//
//  Created by 黄 灿 on 15/7/9.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGRequest.h"

@interface BBGIndexRecomendMoreRequest : BBGRequest
/**
 *  页码
 */
@property (nonatomic,assign) NSInteger pageIndex;

/**
 * size
 */
@property (nonatomic,assign) NSInteger pageSize;
@end
