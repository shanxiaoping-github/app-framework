//
//  BBGUpdateManager.h
//  Components
//
//  Created by elvis.peng on 15-1-15.
//  Copyright (c) 2015年 BuBuGao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBGConstants.h"
#import "BBGMacro.h"
@interface BBGUpdateManager : NSObject
+ (BBGUpdateManager *)sharedInstance;
//检查APP版本更新
- (void)checkAppUpdate;
@end
