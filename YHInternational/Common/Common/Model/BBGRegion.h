//
//  BBGRegion.h
//  Common
//
//  Created by Damon on 15/4/7.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGResponseDataHandler.h"

@interface BBGRegion : BBGResponseDataHandler<NSCoding>

/**
 *  父级区域id
 */
@property (strong,nonatomic) NSString *parentId;
/**
 *  当前区域id
 */
@property (strong,nonatomic) NSString *regionId;
/**
 *  行政区名称
 */
@property (strong,nonatomic) NSString *name;
/**
 *
 */
@property (assign,nonatomic) BOOL leaf;
/**
 *  子区域
 */
@property (strong,nonatomic) NSMutableArray *regionChildren;

@end
