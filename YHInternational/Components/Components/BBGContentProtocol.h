//
//  BBGContentProtocol.h
//  BuBuGao
//
//  Created by calvin on 14-8-14.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBGMenuItem.h"
@protocol BBGContentProtocol <NSObject>

- (void)loadDataWithMenu:(BBGMenuItem *)menu force:(BOOL)force;

@optional
- (void)changeViewController;
- (void)contentViewController:(UINavigationController *)controller;

@optional
/**
 *  是否接收通过外面传递的数据
 *
 *  @return BOOL
 */
- (BOOL)isLoadCustomDataWithMenu:(BBGMenuItem *)menu;
/**
 *  子视图接收通过外面传递的数据
 *
 *  @param data
 */
- (void)distributionData:(id)data;
/**
 *  传递事件
 */
- (void)touchEventWithEventId:(id)sender;
@end
