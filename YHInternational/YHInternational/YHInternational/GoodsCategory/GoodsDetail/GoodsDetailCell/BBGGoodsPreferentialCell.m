//
//  BBGGoodsPreferentialCell.m
//  YHInternational
//
//  Created by 彭腾 on 15-5-6.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGoodsPreferentialCell.h"
#import "BBGGoodsPreferentialDetailCell.h"
#import "BBGPromotionActivities.h"

@implementation BBGGoodsPreferentialCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)cellHeignt:(NSMutableArray *)array {
    CGFloat height = 0 ;
    for (NSInteger i = 0; i < array.count; i++) {
        BBGPromotionActivities *model = array[i] ;
        if ([BBGGoodsPreferentialDetailCell cellHeignt:model]>27) {
            height += [BBGGoodsPreferentialDetailCell cellHeignt:model] ;
        }else {
            height += 27 ;
        }
    }
    return height ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BBGPromotionActivities *model = _dataArr[indexPath.row] ;
    if ([BBGGoodsPreferentialDetailCell cellHeignt:model]>27) {
        return [BBGGoodsPreferentialDetailCell cellHeignt:model] ;
    }else {
        return 27 ;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak BBGGoodsPreferentialCell *weakSelf = self;

    [tableView registerNib:[UINib nibWithNibName:@"BBGGoodsPreferentialDetailCell" bundle:nil] forCellReuseIdentifier:@"BBGGoodsPreferentialDetail"];
    BBGGoodsPreferentialDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBGGoodsPreferentialDetail"];
    BBGPromotionActivities *model = _dataArr[indexPath.row];
    cell.detailBtn.hidden = YES;
    cell.moreImage.hidden = YES;
    if ([model.type isEqualToString:@"ump-order-mjz"]) {
        [cell.detailImage setImage:[UIImage imageNamed:@"gd_fullofgifts"]];
        cell.detailBtn.hidden = NO;
        cell.moreImage.hidden = NO;
        cell.detailBtn.tag = indexPath.row;
        [cell handlerButtonAction:^{
            if (weakSelf.button) {
                weakSelf.button(indexPath.row);
            }
        }];
    }else if ([model.type isEqualToString:@"ump-goods-xscx"]) {
        [cell.detailImage setImage:[UIImage imageNamed:@"gd_promotion"]];
    }else if ([model.type isEqualToString:@"ump-goods-xsqg"]) {
        [cell.detailImage setImage:[UIImage imageNamed:@"gd_panicbuying"]];
    }else if ([model.type isEqualToString:@"ump-order-mlj"]) {
        [cell.detailImage setImage:[UIImage imageNamed:@"gd_fullcut"]];
    }else if ([model.type isEqualToString:@"ump-order-coupon"]) {
        [cell.detailImage setImage:[UIImage imageNamed:@"gd_sendcoupons"]];
    }else if ([model.type isEqualToString:@"ump-order-zk"]) {
        [cell.detailImage setImage:[UIImage imageNamed:@"gd_discount"]];
    }else if ([model.type isEqualToString:@"ump-order-vip-zk"]) {
        [cell.detailImage setImage:[UIImage imageNamed:@"gd_discount"]];
    }else if ([model.type isEqualToString:@"ump-plat-bank"]) {
        [cell.detailImage setImage:[UIImage imageNamed:@"gd_preferential"]];
    }else if ([model.type isEqualToString:@"ump-goods-sjzx"]) {
        [cell.detailImage setImage:[UIImage imageNamed:@"gd_exclusive"]];
    }else if ([model.type isEqualToString:@"ump-goods-groupbuy"]) {
        [cell.detailImage setImage:[UIImage imageNamed:@"gd_groupbuy"]];
    }else if ([model.type isEqualToString:@"ump-order-freeshipping"]) {
        [cell.detailImage setImage:[UIImage imageNamed:@"gd_freeshipping"]];
    }else {
        [cell.detailImage setImage:[UIImage imageNamed:@"gd_preferential"]];
    }
    cell.detailLab.text = model.ad ;
    CGRect cellFrame = cell.frame ;
    cellFrame.size.height = [BBGGoodsPreferentialDetailCell cellHeignt:model] ;
    cell.labelHeight.constant = cellFrame.size.height ;
    cell.frame = cellFrame ;
    [cell setNeedsDisplay] ;
    return cell ;
}

- (void)goGiftButtonAction:(goGiftBlock)block {
    self.button = block;
}

@end
