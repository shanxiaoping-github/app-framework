//
//  BBGAlixpayHandler.h
//  Components
//
//  Created by Damon on 15/5/13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBGPayHandler.h"
#import "BBGPayInfo.h"

@class BBGAlixpayHandler;

@protocol BBGAlixpayDelegate <NSObject>

- (void)alixpayHandler:(BBGAlixpayHandler *)handler payResult:(BBGPayResult)result;

@end

@interface BBGAlixpayHandler : NSObject<BBGPayHandler>

@property (nonatomic, weak) id<BBGAlixpayDelegate> delegate;

- (id)initWithPayInfo:(BBGPayInfo *)payInfo;

@end
