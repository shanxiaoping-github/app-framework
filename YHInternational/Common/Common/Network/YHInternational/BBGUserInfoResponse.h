//
//  BBGUserInfoResponse.h
//  Common
//
//  Created by BubuGao on 15-4-23.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGResponse.h"
#import "BBGUserDetailInfo.h"

@interface BBGUserInfoResponse : BBGResponse

@property (nonatomic,strong) BBGUserDetailInfo *userDetailInfo;

@end
