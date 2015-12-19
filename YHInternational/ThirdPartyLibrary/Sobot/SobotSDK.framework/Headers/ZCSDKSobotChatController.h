//
//  SobotChatController.h
//  SobotSDK
//
//  Created by 张新耀 on 15/8/5.
//  Copyright (c) 2015年 sobot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCInitInfo.h"

/**
 *  聊天页面，仅适用iPhone
 */
@interface ZCSDKSobotChatController : UIViewController

/**
 *  初始化信息
 */
@property(nonatomic,strong) ZCInitInfo  *zcinitInfo;

/**
 *  初始化聊天页面
 *
 *  @param info  企业编号
 *
 *  @return 聊天页面
 */
-(id)initWithInitInfo:(ZCInitInfo *) info;

@end
