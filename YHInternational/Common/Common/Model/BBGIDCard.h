//
//  BBGIDCard.h
//  Common
//
//  Created by Holyjoy on 15/3/4.
//  Copyright (c) 2015年 BuBuGao. All rights reserved.
//

#import "BBGResponseDataHandler.h"

@interface BBGIDCard : BBGResponseDataHandler

/**
 *  身份证姓名
 */
@property (strong,nonatomic) NSString *IDName;
/**
 *  加密身份证号码
 */
@property (strong,nonatomic) NSString *IDNumber;
/**
 *  身份证号码
 */
@property (strong,nonatomic) NSString *mIDNumber;
/**
 *  身份证识别id
 */
@property (assign,nonatomic) NSInteger IDCardId;

/**
 *  @author Damon, 15-03-06 17:03:02
 *
 *  是否选中
 */
@property (assign,nonatomic) BOOL selected;

/**
 *  @author Damon, 15-03-06 17:03:33
 *
 *  是否已经禁用
 */
@property (assign,nonatomic) BOOL disabled;

/**
 *  @author Helen, 15-06-05 15:20:33
 *
 *  是否需要修改
 */

@property (assign,nonatomic) BOOL needEdit;

@property (strong,nonatomic) NSString *editReason;

@property (strong,nonatomic) NSString *frontImgUrl;
@property (strong,nonatomic) NSString *reverseImgUrl;

@property (strong,nonatomic) NSString *frontImgUrlHD;
@property (strong,nonatomic) NSString *reverseImgUrlHD;

@property (strong,nonatomic) NSString *frontImgKey;
@property (strong,nonatomic) NSString *reverseImgKey;
@end

