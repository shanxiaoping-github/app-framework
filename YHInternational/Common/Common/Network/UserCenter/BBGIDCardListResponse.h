//
//  BBGIDCardListResponse.h
//  Common
//
//  Created by holyjoy on 15/3/4.
//  Copyright (c) 2015年 BuBuGao. All rights reserved.
//

#import "BBGResponse.h"
#import "BBGIDCard.h"

@interface BBGIDCardListResponse : BBGResponse
/**
 *  身份证信息列表
 */
@property (strong,nonatomic) NSMutableArray *userIDCardList;

@end
