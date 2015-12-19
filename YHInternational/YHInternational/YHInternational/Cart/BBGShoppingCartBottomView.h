//
//  BBGShoppingCartBottomView.h
//  YHInternational
//
//  Created by yangjie on 15/5/14.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBGProductsCart.h"


typedef enum {
    BBGShoppingCartAllSelected = 0,         //全选
    BBGShoppingCartCancelSelected = 1,      //取消选择
    BBGShoppingCartSomeDelete = -1      //批量删除
}BBGShoppingCartSelectType;

@protocol BBGShoppingCartBottomViewDelegate;

@interface BBGShoppingCartBottomView : UIView

@property (nonatomic,strong) UIButton *allEditBtn;
@property (nonatomic,strong) UIButton *allSelectBtn;
@property (nonatomic,strong) UILabel *selectCountLabel;
@property (nonatomic,strong) UILabel *praiceTitleLabel;
@property (nonatomic,strong) UILabel *totalRealPriceLabel;
@property (nonatomic,strong) UIView *editView;
@property (nonatomic,weak) id<BBGShoppingCartBottomViewDelegate> delegate;

- (void)reloadViewWithCartGroup:(BBGProductsCart*)model;

@end


@protocol BBGShoppingCartBottomViewDelegate <NSObject>

- (void)shoppingCartSelectButtonClick:(BBGShoppingCartSelectType)type;
- (void)shoppingCartEditButtonClick:(BBGShoppingCartSelectType)type;
- (void)tradeCheckout;

@end