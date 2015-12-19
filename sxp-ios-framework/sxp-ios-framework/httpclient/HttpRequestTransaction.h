//
//  HttpTransaction.h
//  gigold
//  Created by 单小萍 on 15/11/27.
//  Copyright © 2015年 wsc. All rights reserved.
//  http事务

#import <Foundation/Foundation.h>
#import "HttpRequestEvent.h"
@interface HttpRequestTransaction : NSObject
//事务请求事件集合
@property(nonatomic,strong)NSMutableArray* httpEventArray;
//事务的执行次数集合
@property(nonatomic,assign)NSUInteger finishCount;
//完成事务操作
@property(nonatomic,assign)void(^completeTransactionOperation)(NSArray* httpEventArray);
//添加请求事件
-(void)addHttpRequestEvent:(HttpRequestEvent*)httpRequestEvent;
//执行http事务
-(void)performHttpTransaction;
//计数事务
-(void)countHttpTransaction;

@end
