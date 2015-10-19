//
//  HttpEvent.h
//  mqsystem
//
//  Created by shanxiaoping on 15-1-31.
//  Copyright (c) 2015年 yicai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperation.h"
@protocol HttpCallBack <NSObject>
@optional
/*成功*/
-(void)success:(id) operation response:(id)responseObject;
/*错误*/
-(void)error:(id) operation error:(NSError*)error;
@end

/*http事件类*/
@interface HttpEvent : NSObject
/*请求地址*/
 @property(nonatomic,strong)NSString* actionUrl;
/*参数*/
@property(nonatomic,strong)NSMutableArray* parames;
/*回调*/
@property(nonatomic,strong)id<HttpCallBack> callBack;
/*添加参数*/
-(void)addParame:(NSString*)value;
@end
