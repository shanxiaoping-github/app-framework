//
//  BBGMaternalORBeautyRequest.h
//  Common
//
//  Created by 刘薇 on 15/7/13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGRequest.h"

@interface BBGMaternalORBeautyRequest : BBGRequest
/*!
 *  1母婴 2美妆  默认是1  3为食品保健
 */
@property (nonatomic, assign) NSInteger tagType;
/*!
 *  分页大小，传20
 */
@property (nonatomic, assign) NSInteger pageSize;
//
///*!
// *  页码
// */
//@property (nonatomic, assign) NSInteger pageNumber;
@end
