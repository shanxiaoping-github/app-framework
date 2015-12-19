//
//  BBGRegionCache.h
//  Common
//
//  Created by Damon on 15/6/16.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBGRegionCache : NSObject

+ (BBGRegionCache *)sharedInstance;

+ (BOOL)updateDB:(NSArray *)array;

+ (NSMutableArray *)queryData;
@end
