//
//  BBGCommentListRequest.h
//  Common
//
//  Created by Holyjoy on 15/4/23.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGRequest.h"

@interface BBGCommentListRequest : BBGRequest

/**
 *  @author holyjoy, 15-04-23 16:04:49
 *
 *  第几页
 */
@property (nonatomic,assign) NSInteger pageNumber;

/**
 *  @author holyjoy, 15-04-23 16:04:45
 *
 *  多少条数据
 */
@property (nonatomic,assign) NSInteger size;


@end
