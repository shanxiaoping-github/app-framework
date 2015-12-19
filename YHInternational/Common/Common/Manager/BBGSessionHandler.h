//
//  BBGSessionHandler.h
//  Common
//
//  Created by Damon on 15/4/23.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^BBGSessionManagerCallback) (BOOL successful);
typedef void (^BBGSessionHandlerCallback) (BOOL successful);

@protocol BBGSessionHandler <NSObject>

- (void)initialize;
- (void)setCallback:(BBGSessionHandlerCallback)callback;

@optional
- (void)showAlert;

@end
