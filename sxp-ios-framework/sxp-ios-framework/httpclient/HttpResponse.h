//
//  HttpResponse.h
//  gigold
//  Created by 单小萍 on 15/11/27.
//  Copyright © 2015年 wsc. All rights reserved.
//  解析后的数据响应
//
#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"
@interface HttpResponse : NSObject
//成功响应
@property(nonatomic,strong)void(^success)(id,id);
//失败响应
@property(nonatomic,strong)void(^faile)(id,NSError*);
@end
