//
//  BBGGetLoginVertificationRequest.m
//  Common
//
//  Created by Damon on 15/4/27.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGetLoginVertificationRequest.h"
#import "BBGGetLoginVertificationResponse.h"
@implementation BBGGetLoginVertificationRequest

- (id)init{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)buildParameters:(BBGMutableParameters *)parameters{
    [super buildParameters:parameters];
}

- (Class)responseClass{
   return [BBGGetLoginVertificationResponse class];
}


@end
