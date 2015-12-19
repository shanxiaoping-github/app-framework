//
//  BBGFilterAttribute.h
//  Common
//
//  Created by calvin on 14-8-22.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import "BBGResponseDataHandler.h"

@interface BBGFilterAttribute : BBGResponseDataHandler

@property (nonatomic, strong) NSString *filterName;
@property (nonatomic, strong) NSArray *attributes;

@end
