//
//  BBGOrderListResponse.h
//  Common
//
//  Created by elvis.peng on 15-5-13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGResponse.h"
#import "BBGOrderInfo.h"
@interface BBGOrderListResponse : BBGResponse
@property (nonatomic,assign)NSInteger currentPage;
@property (nonatomic,assign)NSInteger totalSize;
@property (nonatomic,strong)NSMutableArray *orderList;
@end
