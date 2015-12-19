//
//  BBGSubmitOrderRequest.m
//  Common
//
//  Created by Timmy OuYang on 15/5/19.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGSubmitOrderRequest.h"
#import "BBGSubmitOrderResponse.h"

@implementation BBGSubmitOrderRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.method = BBGHttpMethodPost;
    }
    return self;
}

- (void)buildParameters:(BBGMutableParameters *)parameters {
    [parameters addParameter:BBGPLATFORM forKey:@"source"];
    NSString *buyTypeDescription;
    
    switch (self.buyType) {
        case -1:
            buyTypeDescription = @"group";
            break;
        case 1:
            buyTypeDescription = @"direct";
            break;
        case 2:
            buyTypeDescription = @"normal";
            break;
        case 3:
            buyTypeDescription = @"presale";
            break;

        default:
            break;
    }
    [parameters addParameter:buyTypeDescription forKey:@"buyType"];

}

- (BOOL)needAuthUser {
    
    return YES;
}

- (BOOL)setPlatform {

    return YES;
}

- (Class)responseClass {
    
    return [BBGSubmitOrderResponse class];
}

@end
