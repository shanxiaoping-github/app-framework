//
//  BBGEvaluateRequest.h
//  Common
//
//  Created by Holyjoy on 15/5/11.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGRequest.h"

@interface BBGEvaluateRequest : BBGRequest

@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSString *goodsId;
@property (nonatomic, strong) NSString *isAnonymous;
@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSMutableArray *imgArray;

@end
