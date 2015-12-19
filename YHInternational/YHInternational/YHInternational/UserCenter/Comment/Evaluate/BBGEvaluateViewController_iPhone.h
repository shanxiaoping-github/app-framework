//
//  BBGEvaluateViewController_iPhone.h
//  YHInternational
//
//  Created by Holyjoy on 15/5/9.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGEvaluateViewController.h"

/**
 *  @author holyjoy, 15-05-11 15:05:57
 *
 *  进来评价商品，必须要传的参数  goodsId,shopId  可选参数 orderId
 */

@interface BBGEvaluateViewController_iPhone : BBGEvaluateViewController

@property (nonatomic,strong) NSString *goodsName;
@property (nonatomic,strong) NSString *goodsImageUrl;
@property (nonatomic,strong) NSString *goodsPrice;
@end
