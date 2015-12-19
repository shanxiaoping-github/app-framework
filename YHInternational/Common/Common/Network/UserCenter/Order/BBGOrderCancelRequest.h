//
//  BBGOrderCancelRequest.h
//  Common
//
//  Created by elvis.peng on 15-5-15.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGRequest.h"

@interface BBGOrderCancelRequest : BBGRequest
@property (nonatomic,strong)NSString *orderId;
@property (nonatomic,strong)NSString *cancelReason;
@end
