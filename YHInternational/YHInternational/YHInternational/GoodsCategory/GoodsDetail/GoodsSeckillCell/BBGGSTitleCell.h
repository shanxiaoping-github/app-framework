//
//  BBGGSTitleCell.h
//  YHInternational
//
//  Created by 彭腾 on 15/10/14.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBGGoodsBasicInfo.h"

@interface BBGGSTitleCell : UITableViewCell

+ (CGFloat)cellHeight:(BBGGoodsBasicInfo *)goodsBasicInfo;

- (void)updateCellWith:(BBGGoodsBasicInfo *)goodsBasicInfo;

@end
