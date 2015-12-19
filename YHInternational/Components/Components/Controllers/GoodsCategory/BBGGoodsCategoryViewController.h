//
//  BBGGoodsCategoryViewController.h
//  Components
//
//  Created by Timmy Ouyang on 15/4/26.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGViewController.h"

@interface BBGGoodsCategoryViewController : BBGViewController
/**
 *  后台分类id
 */
@property (nonatomic, strong) NSString *backCate;
/**
 *  前台分类id
 */
@property (nonatomic, strong) NSString *fcate;
/**
 *  搜索关键字
 */
@property (nonatomic, strong) NSString *keywords;

@end
