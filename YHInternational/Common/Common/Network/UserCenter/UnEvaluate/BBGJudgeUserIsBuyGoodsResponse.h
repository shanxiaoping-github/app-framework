//
//  BBGJudgeUserIsBuyGoodsResponse.h
//  Common
//
//  Created by Holyjoy on 15/5/21.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGResponse.h"

@interface BBGJudgeUserIsBuyGoodsResponse : BBGResponse

@property (nonatomic,strong) NSString *orderId;
@property (nonatomic,assign) BOOL hasOrder;
@property (nonatomic,strong) NSString *orderTime;

@end
