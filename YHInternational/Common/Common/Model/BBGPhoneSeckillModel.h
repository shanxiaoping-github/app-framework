//
//  BBGPhoneSeckillModel.h
//  Common
//
//  Created by 彭腾 on 15/7/21.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGResponseDataHandler.h"

@interface BBGPhoneSeckillModel : BBGResponseDataHandler
/**
 *  秒杀活动ID
 */
@property (nonatomic,copy) NSString *Id;
/**
 *  活动名称
 */
@property (nonatomic,copy) NSString *name;
/**
 *  结束时间
 */
@property (nonatomic,copy) NSString *endDate;
/**
 *  开始时间
 */
@property (nonatomic,copy) NSString *startDate;
/**
 *  活动下货品集合
 */
@property (nonatomic,strong) NSMutableArray *products;
/**
 *  创建时间
 */
@property (nonatomic,copy) NSString *createDate;
/**
 *  修改时间
 */
@property (nonatomic,copy) NSString *modifyDate;

@end
