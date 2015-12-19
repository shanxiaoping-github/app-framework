//
//  BBGUploadUserHeadResponse.h
//  Common
//
//  Created by yangjie on 15/4/28.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGResponse.h"
#import "BBGUserHeader.h"

@interface BBGUploadUserHeadResponse : BBGResponse


@property (nonatomic,strong) BBGUserHeader *userHeader;

@end
