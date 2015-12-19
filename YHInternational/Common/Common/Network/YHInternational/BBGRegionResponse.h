//
//  BBGRegionResponse.h
//  Common
//
//  Created by Damon on 15/5/9.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGResponse.h"
#import "BBGRegion.h"

@interface BBGRegionResponse : BBGResponse

@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSMutableArray *regionList;

/**
 *  待操作SQL语句
 */
@property (nonatomic, strong) NSMutableArray * operatorList;
@end
