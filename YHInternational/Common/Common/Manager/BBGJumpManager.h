//
//  BBGJumpManager.h
//  Common
//
//  Created by Damon on 15/5/6.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^CancelAction)();

typedef NS_ENUM(NSInteger, BBGJumpType) {
    BBGJumpShopMall,      //跳转首页
    BBGJumpCart,          //跳转购物车
    BBGJumpOrderList      //跳转订单列表
};

@protocol BBGJumpObserver <NSObject>

- (void)jumpTo:(NSNumber *)type;

@end

@interface BBGJumpManager : NSObject

+(BBGJumpManager *)sharedInstance;
- (void)addObserver:(id<BBGJumpObserver>)observer;
- (void)removeObserver:(id<BBGJumpObserver>)observer;
- (void)managerJumpTo:(BBGJumpType)type;

@property (assign, nonatomic) NSInteger selectedIndex;
@property (assign, nonatomic) UITabBarController * tabBarController;

@property (strong, nonatomic) UIView * animationView;

@end
