//
//  BeautyEffectViewController.h
//  Components
//
//  Created by 彭腾 on 15/7/9.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGViewController.h"
#import "BBGBeautyEffectRequest.h"

@interface BBGBeautyEffectViewController : BBGViewController
/**
 *  美妆功效数组
 */
@property (nonatomic,strong) NSMutableArray *beautyArr;
/**
 *  美妆功效请求
 */
@property (nonatomic,strong) BBGBeautyEffectRequest *beautyRequest;

@end
