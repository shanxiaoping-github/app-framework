//
//  BBGURLManager.h
//  Common
//
//  Created by yangjie on 15/6/26.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TEST

#ifdef TEST
#define UMENG_APPKEY @""
#define UNIONPAYMODE @""
#else
#define UMENG_APPKEY @""
#define UNIONPAYMODE @""
#endif

#ifdef TEST
#define SERVER_URL_ROOT @""
#else
#define SERVER_URL_ROOT @""
#endif

extern NSString *SERVER_URL;

@interface BBGURLManager : NSObject

@end
