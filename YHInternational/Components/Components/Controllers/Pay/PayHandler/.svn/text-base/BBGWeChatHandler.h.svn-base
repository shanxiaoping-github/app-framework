//
//  BBGWeChatHandler.h
//  Components
//
//  Created by calvin on 14-9-2.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBGPayHandler.h"
#import "BBGPayInfo.h"

@class BBGWeChatHandler;

@protocol BBGWeChatDelegate <NSObject>

- (void)weChatHandler:(BBGWeChatHandler *)handler payResult:(BBGPayResult)result;

@end

@interface BBGWeChatHandler : NSObject <BBGPayHandler>

@property (nonatomic, assign) id<BBGWeChatDelegate> delegate;

- (id)initWithPayInfo:(BBGPayInfo *)payInfo;

@end
