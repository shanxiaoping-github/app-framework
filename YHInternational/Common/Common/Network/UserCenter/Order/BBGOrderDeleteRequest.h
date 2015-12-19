//
//  BBGOrderDeleteRequest.h
//  Common
//
//  Created by elvis.peng on 15-5-13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGRequest.h"

@interface BBGOrderDeleteRequest : BBGRequest
@property (nonatomic,strong)NSString *orderId;
@property (nonatomic,strong)NSString *memberId;
@end
