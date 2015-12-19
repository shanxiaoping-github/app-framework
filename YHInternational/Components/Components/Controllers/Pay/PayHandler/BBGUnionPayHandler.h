//
//  BBGUnionPayHandler.h
//  Components
//
//  Created by calvin on 14-9-2.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBGPayHandler.h"
#import "BBGPayInfo.h"

@class BBGUnionPayHandler;

@protocol BBGUnionPayDelegate <NSObject>

- (void)unionPayHandler:(BBGUnionPayHandler *)handler payResult:(BBGPayResult)result;

@end

@interface BBGUnionPayHandler : NSObject <BBGPayHandler>

@property (nonatomic, strong) UIViewController * fromVC;

@property (nonatomic, weak) id<BBGUnionPayDelegate> delegate;

- (id)initWithPayInfo:(BBGPayInfo *)payInfo;

@end
