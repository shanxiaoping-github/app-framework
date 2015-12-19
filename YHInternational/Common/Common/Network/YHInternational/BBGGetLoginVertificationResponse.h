//
//  BBGGetLoginVertificationResponse.h
//  Common
//
//  Created by Damon on 15/4/27.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGResponse.h"

@interface BBGGetLoginVertificationResponse : BBGResponse
@property (nonatomic, strong) NSString * imageUrl;
@property (nonatomic, strong) NSString * sessionId;
@end
