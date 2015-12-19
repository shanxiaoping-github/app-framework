//
//  BBGPmsMessage.h
//  Common
//
//  Created by elvis.peng on 15-5-19.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGResponseDataHandler.h"

@interface BBGPmsMessage : BBGResponseDataHandler
@property (nonatomic,strong)NSString *pmsId;
@property (nonatomic,strong)NSString *message;
@property (nonatomic,strong)NSDate *begintime;
@property (nonatomic,strong)NSDate *endtime;
@property (nonatomic,strong)NSString *type;
@end
