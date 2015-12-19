//
//  BBGUpdateUserNameResponse.h
//  Common
//
//  Created by yangjie on 15/4/28.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGResponse.h"
#import "BBGUserDetailInfo.h"

@interface BBGUpdateUserNameResponse : BBGResponse

@property (nonatomic,strong) BBGUserDetailInfo *userDetailInfo;

@end
