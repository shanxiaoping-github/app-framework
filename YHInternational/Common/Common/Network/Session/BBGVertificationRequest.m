//
//  BBGVertificationRequest.m
//  Common
//
//  Created by Damon on 15/4/27.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGVertificationRequest.h"
#import "BBGVertificationResponse.h"
@implementation BBGVertificationRequest

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
    return [BBGVertificationResponse class];
}

@end