//
//  BBGPmsMsgRequest.h
//  Common
//
//  Created by elvis.peng on 15-5-19.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGRequest.h"

@interface BBGPmsMsgRequest : BBGRequest
/**
 *  1首页；2支付公告
 */
@property (nonatomic,strong)NSString *atType;
@end
