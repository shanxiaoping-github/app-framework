//
//  BBGLaunchTask.h
//  Common
//
//  Created by Damon on 15/4/23.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^BBGLaunchTaskFinished) (BOOL successful);

@protocol BBGLaunchTask <NSObject>

/*!
 * @param finished 任务完成后的回调block
 */
- (void)launchTask:(BBGLaunchTaskFinished)finished;

/*!
 * @return 任务名称
 */
- (NSString *)taskName;

@end
