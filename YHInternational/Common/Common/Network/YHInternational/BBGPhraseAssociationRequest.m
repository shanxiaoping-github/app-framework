//
//  BBGPhraseAssociationRequest.m
//  Common
//
//  Created by Holyjoy on 15/3/23.
//  Copyright (c) 2015年 BuBuGao. All rights reserved.
//

#import "BBGPhraseAssociationRequest.h"
#import "BBGPhraseAssociationResponse.h"

@implementation BBGPhraseAssociationRequest

- (id)init {
    self = [super init];
    if (self) {
        self.method = BBGHttpMethodPost;
    }
    return self;
}

- (void)buildParameters:(BBGMutableParameters *)parameters {
    [parameters addParameter:self.keywords forKey:@"prefixStr"];
    [super buildParameters:parameters];
}

- (BOOL)needAuthUser {
    return NO;
}

- (Class)responseClass {
    
    return [BBGPhraseAssociationResponse class];
}
@end