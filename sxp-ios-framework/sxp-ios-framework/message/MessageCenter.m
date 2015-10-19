//
//  MessageCenter.m
//  WMF
//
//  Created by 单小萍 on 15/7/10.
//  Copyright (c) 2015年 beijingwomaifang. All rights reserved.
//

#import "MessageCenter.h"

@implementation MessageCenter
+(instancetype)sharedInstance{
    static MessageCenter* messageCenter = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        messageCenter = [MessageCenter new];
    });
    return messageCenter;
}

-(void)registMessageObserver:(id)observeObj selector:(SEL)sel name:(NSString *)msgName sendObj:(id)sendObj{
    [[NSNotificationCenter defaultCenter] addObserver:observeObj selector:sel name:msgName object:sendObj];
}
-(void)postMessage:(NSString *)msgName sendObj:(id)sendObj{
    [[NSNotificationCenter defaultCenter] postNotificationName:msgName object:sendObj];
}
-(void)postMessage:(NSString *)msgName sendObj:(id)sendObj data:(NSDictionary *)dataInfo{
    [[NSNotificationCenter defaultCenter]postNotificationName:msgName object:sendObj userInfo:dataInfo];
}
@end
