//
//  BBGMoreMaternalORBeautyRequest.h
//  Common
//
//  Created by 刘薇 on 15/7/27.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGRequest.h"

@interface BBGMoreMaternalORBeautyRequest : BBGRequest
/*!
 *  1母婴 2美妆  0推荐
 */
@property (nonatomic, assign) NSInteger type;
/*!
 *  分页大小，默认20
 */
@property (nonatomic, assign) NSInteger pageSize;

/*!
 *  页码
 */
@property (nonatomic, assign) NSInteger pageIndex;
@end
