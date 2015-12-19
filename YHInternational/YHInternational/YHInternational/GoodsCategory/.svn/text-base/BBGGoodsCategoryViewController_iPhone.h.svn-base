//
//  BBGGoodsCategoryViewController_iPhone.h
//  YHInternational
//
//  Created by Timmy Ouyang on 15/4/26.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGoodsCategoryViewController.h"

@protocol BBGGoodsFilterDelegate;
@interface BBGGoodsCategoryViewController_iPhone : BBGGoodsCategoryViewController

@property (assign, nonatomic) id <BBGGoodsFilterDelegate> delegate;
/**
 *  筛选条件
 */
@property (nonatomic, strong) NSArray *filterAttributes;
/**
 *  清除筛选条件
 */
- (void)clearFilter;

@end

@protocol BBGGoodsFilterDelegate <NSObject>

/**
 *  @brief  执行筛选
 *
 *  @param catController self
 *  @param filters       筛选调节map
 *  @param hasStore      是否只显示有货
 *  @param isProprietary 是否只显示自营
 */
- (void)categoryController:(BBGGoodsCategoryViewController_iPhone *)catController allFilters:(NSDictionary *)filters hasStore:(BOOL)hasStore isProprietary:(BOOL)isProprietary;

@end
