//
//  BBGOrderSelfArea.h
//  Common
//
//  Created by elvis.peng on 15-5-13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGResponseDataHandler.h"

@interface BBGOrderSelfArea : BBGResponseDataHandler
@property (nonatomic,strong)NSString *orderId;
@property (nonatomic,strong)NSString *selfId;
@property (nonatomic,strong)NSString *regionId;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *address;
@property (nonatomic,strong)NSString *tel;
@property (nonatomic,strong)NSString *username;
@end
