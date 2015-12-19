//
//  BBGActivityManager.h
//  Common
//
//  Created by Damon on 15/5/22.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBGMacro.h"
#import "BBGLaunchTask.h"
#import "BBGShareModel.h"
@interface BBGActivityManager : NSObject<BBGLaunchTask>
+(BBGActivityManager *)sharedInstance;

- (void)firstShareData:(void (^)(BOOL successful,id response))callback;

@property (nonatomic, strong) BBGShareModel *model ;

@end
