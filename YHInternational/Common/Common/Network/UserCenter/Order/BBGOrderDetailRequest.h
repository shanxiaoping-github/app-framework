//
//  BBGOrderDetailRequest.h
//  Common
//
//  Created by elvis.peng on 15-5-14.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGRequest.h"

@interface BBGOrderDetailRequest : BBGRequest
@property (nonatomic,strong)NSString *orderId;
@property (nonatomic,strong)NSString *shopId;
@end
