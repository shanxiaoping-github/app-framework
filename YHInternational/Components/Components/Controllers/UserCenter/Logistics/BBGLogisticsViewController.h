//
//  BBGLogisticsViewController.h
//  Components
//
//  Created by Damon on 15/5/16.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGViewController.h"

@interface BBGLogisticsViewController : BBGViewController

/*!
 *  数据列表
 */
@property (nonatomic, strong) NSMutableArray * listArray;
/*!
 *  分页大小
 */
@property (nonatomic, assign) NSInteger pageSize;

/*!
 *  当前页码
 */
@property (nonatomic, assign) NSInteger pageNumber;

- (void)getLogisticData:(void (^)(BOOL successful, id responseData))block;

@end
