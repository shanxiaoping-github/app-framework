//
//  BBGPayCenter.h
//  Components
//
//  Created by Damon on 15/5/13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBGPayInfo.h"
#import "BBGPayHandler.h"

typedef void (^PayAction)(BBGPayResult result);

@interface BBGPayCenter : NSObject


+(BBGPayCenter *)sharedInstance;

- (void)setResultAction:(PayAction)block;

- (id<BBGPayHandler>)buildPayHandlerWith:(BBGPayInfo *)payInfo viewController:(UIViewController *)fromVC;

- (void)handleAlixpayURL:(NSURL *)url;
- (void)handleWeChatURL:(NSURL *)url;

@end
