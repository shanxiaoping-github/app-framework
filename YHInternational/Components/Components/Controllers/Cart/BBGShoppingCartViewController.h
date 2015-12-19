//
//  BBGShoppingCarViewController.h
//  Components
//
//  Created by yangjie on 15/5/11.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGViewController.h"

@interface BBGShoppingCartViewController : BBGViewController

@property (nonatomic,strong) BBGProductsCart *productsCart;

@property (nonatomic,strong) BBGUpdateCartRequest *updateCartRequest;

@property (nonatomic,strong) BBGCheckCartRequest *checkCartRequest;

@property (nonatomic,strong) BBGCartRemoveRequest *removeCartRequest;

/**
 *  修改购物车
 *
 *  @param callback <#callback description#>
 */
- (void)shoppingCartUpdate:(LoadDataCallback)callback;

/**
 *  购物车选择
 *
 *  @param callback <#callback description#>
 */
- (void)shoppingCartChechk:(LoadDataCallback)callback;

/**
*  购物车删除
*
*  @param callback <#callback description#>
*/
- (void)shoppingCartRemove:(LoadDataCallback)callback;

@end
