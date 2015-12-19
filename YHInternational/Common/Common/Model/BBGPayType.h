//
//  BBGPayType.h
//  Common
//
//  Created by elvis.peng on 15-5-15.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGResponseDataHandler.h"

@interface BBGPayType : BBGResponseDataHandler
@property (nonatomic,strong)NSString *payCode;
@property (nonatomic,strong)NSString *payName;
@property (nonatomic,strong)NSString *iconUrl;
@end
