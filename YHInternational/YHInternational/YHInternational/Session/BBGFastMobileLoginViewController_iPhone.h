//
//  BBGFastMobileLoginViewController_iPhone.h
//  YHInternational
//
//  Created by Holyjoy on 15/6/9.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGFastMobileLoginViewController.h"

@interface BBGFastMobileLoginViewController_iPhone : BBGFastMobileLoginViewController

- (id)initWithBlock:(FastLoginBlock)block;

//获取短信验证码成功
@property (nonatomic,assign) BOOL smsSucsessful;
//需要图形验证码
@property (nonatomic,assign) BOOL needImageCode;
//已插入图像验证码cell
@property (nonatomic,assign) BOOL hadInsetImageCodecell;


@end
