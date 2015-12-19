//
//  BBGGoodsShopCell.h
//  YHInternational
//
//  Created by 彭腾 on 15/6/25.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBGGoodsBasicInfo.h"

typedef void (^ActionBlock)();

@interface BBGGoodsShopCell : UITableViewCell
@property (nonatomic, copy) ActionBlock button;
- (void)handlerButtonAction:(ActionBlock)block;
- (void)updateCellWith:(BBGGoodsBasicInfo *)goods;

@end
