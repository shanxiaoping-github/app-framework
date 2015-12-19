//
//  BBGGoodsSeckillViewController_iPhone.h
//  YHInternational
//
//  Created by 彭腾 on 15/10/14.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGoodsSeckillViewController.h"
#import "BBGAdvView.h"

@interface BBGGoodsSeckillViewController_iPhone : BBGGoodsSeckillViewController
/**
 *  商品秒杀详情table
 */
@property (nonatomic, strong) UITableView *BBGGoodsSeckill;
/**
 *  分享图片
 */
@property (nonatomic, strong) UIImageView *shareImageView;
/**
 *  底部主视图
 */
@property (nonatomic, strong) UIView *bottomView;
/**
 *  商品详情web页
 */
@property (nonatomic, strong) UIWebView *webView;

@end
