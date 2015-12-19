//
//  BBGSearchFilterRequest.m
//  Common
//
//  Created by Timmy OuYang on 15/5/23.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGSearchFilterRequest.h"
#import "BBGSearchFilterResponse.h"

@implementation BBGSearchFilterRequest


- (id)init {
    self = [super init];
    if (self) {
        self.method = BBGHttpMethodPost;
        self.page = 1;
        self.pageSize = 20;
    }
    return self;
}

- (void)buildParameters:(BBGMutableParameters *)parameters {
    
    [parameters addParameter:_backCate forKey:@"backCate"];
    [parameters addParameter:_lastFCate forKey:@"lastFCate"];
    [parameters addParameter:_lastKWs forKey:@"lastKWs"];

    [parameters addParameter:[NSString stringWithFormat:@"%lu",(unsigned long)_page] forKey:@"pageIndex"];
    [parameters addParameter:[NSString stringWithFormat:@"%lu",(unsigned long)_pageSize] forKey:@"pageSize"];
}

- (Class)responseClass {
    return [BBGSearchFilterResponse class];
}

@end
