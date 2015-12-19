//
//  BBGBugFixManager.h
//  Common
//
//  Created by yangjie on 15/10/23.
//  Copyright © 2015年 Bubugao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Common.h"
#import "BBGLaunchTask.h"

@interface BBGBugFixManager : NSObject<BBGLaunchTask>

+ (BBGBugFixManager *)sharedInstance;

@end
