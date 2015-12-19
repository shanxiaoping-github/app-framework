//
//  BBGShoppingCartHeaderView.h
//  YHInternational
//
//  Created by yangjie on 15/5/13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBGProductsCartGroup.h"


@protocol BBGShoppingCartHeaderViewDelegate;

@interface BBGShoppingCartHeaderView : UIView

@property (nonatomic,strong)UIButton *selectBtn;
@property (nonatomic,strong)UIImageView *shopIconImageView;
@property (nonatomic,strong)UILabel *shopNameLabel;

@property (nonatomic,assign)NSInteger section;

@property (nonatomic,weak)id<BBGShoppingCartHeaderViewDelegate> delegate;

- (void)reloadViewWithModel:(BBGProductsCartGroup*)model;
@end


@protocol BBGShoppingCartHeaderViewDelegate <NSObject>

- (void)selectedSection:(NSInteger)section;

@end