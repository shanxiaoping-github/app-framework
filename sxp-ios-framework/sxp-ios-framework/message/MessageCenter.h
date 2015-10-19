//
//  MessageCenter.h
//  WMF
//
//  Created by 单小萍 on 15/7/10.
//  Copyright (c) 2015年 beijingwomaifang. All rights reserved.
//
/*通知中心*/
#import <Foundation/Foundation.h>
//聊天消息
#define CHAT_MESSAGE @"chat_message"
//改变属性
#define CHANGE_USER_ATR @"chang_user_atr"
@interface MessageCenter : NSObject
/*获取单例*/
+(instancetype)sharedInstance;
/*添加监听者*/
-(void)registMessageObserver:(id)observeObj selector:(SEL)sel name:(NSString*)msgName sendObj:(id)sendObj;
/*发送消息*/
-(void)postMessage:(NSString*)msgName sendObj:(id)sendObj;
/*发送消息，带数据*/
-(void)postMessage:(NSString *)msgName sendObj:(id)sendObj data:(NSDictionary*)dataInfo;
@end
