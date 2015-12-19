//
//  BBGPaySignInfoRequest.h
//  Common
//
//  Created by elvis.peng on 15-5-19.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGRequest.h"

@interface BBGPaySignInfoRequest : BBGRequest
@property (nonatomic,strong)NSArray *orderIds;
@property (nonatomic,strong)NSString *payment;
@end
