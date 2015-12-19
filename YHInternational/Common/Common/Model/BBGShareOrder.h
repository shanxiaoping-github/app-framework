//
//  BBGShareOrder.h
//  Common
//
//  Created by yousai on 15/10/27.
//  Copyright © 2015年 Bubugao. All rights reserved.
//  晒单对象

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface BBGShareOrder : NSObject

//商品名称
@property (nonatomic,strong) NSString *goodsName;
//商品图片
@property (nonatomic,strong) NSString *goodsImageUrl;
//商品价格
@property (nonatomic,strong) NSString *goodsPrice;
//评论内容
@property (nonatomic,strong) NSString *comment;

//晒单的时候需要上传的图片
@property (nonatomic,strong) NSMutableArray *picDataArray;

@property (nonatomic,strong) NSArray *topicArray;

//话题是否被选中
@property (nonatomic,strong) NSMutableArray *topicIsSelectArray;

@property (nonatomic) BOOL isOpenTopic;

//默认高度
@property (nonatomic) CGFloat defaultTopicHeight;

//展开的高度
@property (nonatomic) CGFloat openTopicHeight;


-(void)mathOpenTopicHeight:(CGFloat)iphoneWidth;

@end
