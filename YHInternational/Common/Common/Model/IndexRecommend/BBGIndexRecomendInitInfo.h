//
//  BBGIndexRecomendInitInfo.h
//  Common
//
//  Created by 黄 灿 on 15/8/25.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGResponseDataHandler.h"

@interface BBGIndexRecomendInitInfo : BBGResponseDataHandler
/**
 *  id
 */

@property(nonatomic,strong)NSString *Id;

/**
 *  Name
 */

@property(nonatomic,strong)NSString *Name;


/**
 *  图片
 */

@property(nonatomic,strong)NSString *img;

/**
 *  链接地址
 */

@property(nonatomic,strong)NSString *url;

/**
 *  从左至右排序
 */

@property(nonatomic,strong)NSString *sort;


/**
 *  分类
 */
@property (nonatomic, strong) NSString *btnId;

@end
