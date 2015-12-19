//
//  BBGLogisticsRequest.m
//  Common
//
//  Created by Damon on 15/5/18.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGLogisticsRequest.h"
#import "BBGLogisticsResponse.h"
@implementation BBGLogisticsRequest

- (id)init{
    self = [super init];
    if (self) {
        self.method = BBGHttpMethodPost;
    }
    return self;
}

- (void)buildParameters:(BBGMutableParameters *)parameters{
    [parameters addParameter:@"4" forKey:@"type"];
    [parameters addParameter:[NSString stringWithFormat:@"%ld",(long)self.pageSize] forKey:@"pageSize"];
    [parameters addParameter:[NSString stringWithFormat:@"%ld",(long)self.pageNo] forKey:@"pageNo"];
    [super buildParameters:parameters];
}

- (BOOL)needAuthUser{
    return YES;
}

- (Class)responseClass{
    return [BBGLogisticsResponse class];
}

@end
