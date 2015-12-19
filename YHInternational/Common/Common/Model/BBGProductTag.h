//
//  BBGProductTag.h
//  Common
//
//  Created by 文礼 on 14/11/18.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "BBGResponseDataHandler.h"


typedef enum {
    Tag_Location_TopRight = 100,
    Tag_Location_Center = 200,
    
}Tag_Location;

@interface BBGProductTag : BBGResponseDataHandler
/**
 *  标签名称
 */
@property (nonatomic, strong) NSString *tagName;
/**
 *  标签id
 */
@property (nonatomic, strong) NSNumber *tagId;
/**
 *  标签位置
 */
@property (nonatomic, assign) Tag_Location location;
/**
 *  标签是否要显示
 */
@property (nonatomic, assign) BOOL showInView;
/**
 *  标签背景色
 */

@property (nonatomic, strong) UIColor *bgColor;
/**
 *  标签字体颜色
 */
@property (nonatomic, strong) UIColor *fontColor;
@end
