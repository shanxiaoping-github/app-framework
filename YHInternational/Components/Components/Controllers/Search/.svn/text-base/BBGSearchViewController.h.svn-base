//
//  BBGSearchViewController.h
//  Components
//
//  Created by Holyjoy on 15/3/20.
//  Copyright (c) 2015年 BuBuGao. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "BBGViewController.h"
#import "Common.h"

@interface BBGSearchViewController :BBGViewController

/**
 *  @author holyjoy, 15-03-23 15:03:52
 *
 *  输入关键词时返回的联想词组
 */
@property (nonatomic,strong) NSMutableArray *phraseAssociationArray;

/**
 *  @author holyjoy, 15-03-23 17:03:21
 *
 *  输入的关键字
 */
@property (nonatomic,strong) NSString *keyWords;

/**
 *  @author holyjoy, 15-03-24 10:03:14
 *
 *  历史纪录
 */
@property (nonatomic,strong) NSMutableArray *searchHistoryArray;

/**
 *  门店ID
 */
@property (nonatomic, strong) NSString *shopId;

/**
 *  门店类型 1 三 2 门 3 自营（多个用，隔开）
 */
@property (nonatomic, strong) NSString* shopType;


/**
 *  @author holyjoy, 15-03-24 10:03:06
 *
 *  从缓存加载历史纪录
 */
- (void)loadSearchHistory;
@end
