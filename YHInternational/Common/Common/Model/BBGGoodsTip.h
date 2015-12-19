//
//  BBGGoodsTip.h
//  Common
//
//  Created by 彭腾 on 15-5-7.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGResponseDataHandler.h"

@interface BBGGoodsTip : BBGResponseDataHandler
/**
 *  排序id
 */
@property (nonatomic, assign) NSInteger sortId;
/**
 *  贴士key
 */
@property (nonatomic, copy) NSString *tipTitle;
/**
 *  贴士value
 */
@property (nonatomic, copy) NSString *titContent;

@end
