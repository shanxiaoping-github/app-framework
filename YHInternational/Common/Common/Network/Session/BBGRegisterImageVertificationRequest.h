//
//  BBGRegisterImageVertificationRequest.h
//  Common
//
//  Created by Damon on 15/4/28.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGRequest.h"

@interface BBGRegisterImageVertificationRequest : BBGRequest
@property (nonatomic, strong) NSString * sessionId;
//是否来自快捷登录
@property (nonatomic, assign) BOOL isFromFastLoginCtrl;
@end
