//
//  BBGGoodsDetailImages.h
//  Common
//
//  Created by 彭腾 on 15-5-7.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGResponseDataHandler.h"

@interface BBGGoodsDetailImages : BBGResponseDataHandler
/**
 *  图片url
 */
@property (nonatomic, copy) NSString *imageUrl;
/**
 *  图片key
 */
@property (nonatomic, copy) NSString *imageKey;

@end
