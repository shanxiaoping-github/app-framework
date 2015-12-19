//
//  ZCSobot.h
//  SobotSDK
//
//  Created by zhangxy on 15/8/26.
//  Copyright (c) 2015年 sobot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCInitInfo.h"

@interface ZCSobot : NSObject

/**
 *  启动智齿客服
 *
 *  @param info         初始化参数，详情见ZCInitInfo not null
 *  @param byController 当前执行跳转的对象           not null
 */
+(void)startZCChatView:(ZCInitInfo *) info with:(UIViewController *) byController;


/**
 *  获取系统版本号
 *
 *  @return 版本号
 */
+(NSString *)getVersion;



@end
