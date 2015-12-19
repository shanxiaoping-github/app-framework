//
//  HttpTransaction.m
//  gigold
//
//  Created by 单小萍 on 15/11/27.
//  Copyright © 2015年 wsc. All rights reserved.
//

#import "HttpRequestTransaction.h"
@implementation HttpRequestTransaction
@synthesize httpEventArray=_httpEventArray;
@synthesize finishCount=_finishCount;
@synthesize completeTransactionOperation=_completeTransactionOperation;
//添加请求事件
-(void)addHttpRequestEvent:(HttpRequestEvent *)httpRequestEvent{
    if (!_httpEventArray) {
        self.httpEventArray = [[NSMutableArray alloc]init];
    }
    httpRequestEvent.belongHttpRequestTransaction = self;
    [_httpEventArray addObject:httpRequestEvent];
}
//启动执行事务
-(void)performHttpTransaction{
    if (_httpEventArray) {
        for (HttpRequestEvent* httpRequestEvent in _httpEventArray) {
            [httpRequestEvent submitRequest];
        }
    }
}
//计数事务，当每个http请求完成之后 记数一次
-(void)countHttpTransaction{
    _finishCount++;
    if (_finishCount >= _httpEventArray.count){
        [self completeHttpTransaction];
    }
}
//完成事务
-(void)completeHttpTransaction{
    if (_completeTransactionOperation) {
        _completeTransactionOperation(_httpEventArray);
    }
}
@end
