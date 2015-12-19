//
//  BBGSimpleCartGetResponse.m
//  Common
//
//  Created by yangjie on 15/5/22.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGSimpleCartGetResponse.h"
#import "BBGCartManager.h"

@implementation BBGSimpleCartGetResponse

- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format{
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
        
        BBGSimpleCartModel *model = [[BBGSimpleCartModel alloc] initWithHandler:self responseData:self.responseData];
        self.simpleCartModel = model;
        
        [BBGCartManager sharedInstance].cartCount = @(model.totalType);
        
    }
    return self;
}

@end
