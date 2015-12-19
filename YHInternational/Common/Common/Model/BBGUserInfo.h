//
//  BBGUserInfo.h
//  Common
//
//  Created by Damon on 15/4/22.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGResponseDataHandler.h"

@interface BBGUserInfo : BBGResponseDataHandler<NSCoding>

@property (nonatomic, strong) NSString * memberId;

@property (nonatomic, strong) NSString * accessToken;

@property (nonatomic, strong) NSString * userSecret;

@end
