//
//  BBGAddIDCardRequest.m
//  Common
//
//  Created by holyjoy on 15/3/5.
//  Copyright (c) 2015年 BuBuGao. All rights reserved.
//

#import "BBGAddIDCardRequest.h"
#import "BBGAddIDCardResponse.h"

@implementation BBGAddIDCardRequest

- (id)init {
    self = [super init];
    if (self) {
        self.method = BBGHttpMethodPost;
    }
    return self;
}

- (void)buildParameters:(BBGMutableParameters *)parameters {
    
    [parameters addParameter:self.IDCard.IDName forKey:@"name"];
    [parameters addParameter:self.IDCard.IDNumber forKey:@"idCard"];
    
    [parameters addParameter:self.IDCard.frontImgKey forKey:@"frontImgKey"];
    [parameters addParameter:self.IDCard.reverseImgKey forKey:@"reverseImgKey"];
    
    [super buildParameters:parameters];
}

- (BOOL)needAuthUser {
    return YES;
}

- (Class)responseClass {
    return [BBGAddIDCardResponse class];
}


@end
