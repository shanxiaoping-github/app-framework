//
//  BBGLogisticsSection.m
//  YHInternational
//
//  Created by Damon on 15/5/16.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGLogisticsSection.h"
#import "BBGOrderInfo.h"
#import "BBGTools.h"
@interface BBGLogisticsSection ()
@property (strong, nonatomic) IBOutlet UILabel *orderLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView1;
@property (strong, nonatomic) IBOutlet UIImageView *imageView2;
@property (strong, nonatomic) IBOutlet UIImageView *imageView3;
@property (strong, nonatomic) IBOutlet UIImageView *imageView4;
@property (strong, nonatomic) IBOutlet UIImageView *imageView5;

@end

@implementation BBGLogisticsSection

- (void)updateSection:(id)response{
    BBGOrderInfo * orderInfo = response;
    self.orderLabel.text = [NSString stringWithFormat:@"订单号：%@",orderInfo.orderId];
    self.timeLabel.text = [NSString stringWithFormat:@"%@",[BBGTools timeToString:orderInfo.orderCreateTime.timeIntervalSince1970 Format:@"YYYY-MM-dd"]];
    
    if (IPHONE_WIDTH > 320) {
        BBGOrderProduct * product1 = orderInfo.productList[0];
        [_imageView1 sd_setImageWithURL:[NSURL URLWithString:product1.imageUrl]];
        if (orderInfo.productList.count > 1) {
            BBGOrderProduct * product2 = orderInfo.productList[1];
            [_imageView2 sd_setImageWithURL:[NSURL URLWithString:product2.imageUrl]];
        }
        if (orderInfo.productList.count > 2) {
            BBGOrderProduct * product3 = orderInfo.productList[2];
            [_imageView3 sd_setImageWithURL:[NSURL URLWithString:product3.imageUrl]];
        }
        if (orderInfo.productList.count > 3) {
            BBGOrderProduct * product4 = orderInfo.productList[3];
            [_imageView4 sd_setImageWithURL:[NSURL URLWithString:product4.imageUrl]];
        }
        
        if (orderInfo.productList.count > 4) {
            BBGOrderProduct * product5 = orderInfo.productList[4];
            [_imageView5 sd_setImageWithURL:[NSURL URLWithString:product5.imageUrl]];
        }
    }else{
        BBGOrderProduct * product1 = orderInfo.productList[0];
        [_imageView1 sd_setImageWithURL:[NSURL URLWithString:product1.imageUrl]];
        
        if (orderInfo.productList.count > 1) {
            BBGOrderProduct * product2 = orderInfo.productList[1];
            [_imageView2 sd_setImageWithURL:[NSURL URLWithString:product2.imageUrl]];
        }
        
        if (orderInfo.productList.count > 2) {
            BBGOrderProduct * product3 = orderInfo.productList[2];
            [_imageView3 sd_setImageWithURL:[NSURL URLWithString:product3.imageUrl]];
        }
        
        if (orderInfo.productList.count > 3) {
            BBGOrderProduct * product4 = orderInfo.productList[3];
            [_imageView4 sd_setImageWithURL:[NSURL URLWithString:product4.imageUrl]];
        }
        
        
        
    }
    
}

- (void)awakeFromNib {
    self.isSpread = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
