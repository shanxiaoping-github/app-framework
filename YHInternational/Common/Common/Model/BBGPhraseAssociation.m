//
//  BBGPhraseAssociation.m
//  Common
//
//  Created by Holyjoy on 15/3/23.
//  Copyright (c) 2015年 BuBuGao. All rights reserved.
//

#import "BBGPhraseAssociation.h"

@implementation BBGPhraseAssociation

- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
//            return self;
        }
        STRING_FOR_KEY(self.associationedKeyword, @"keyword")
        INTEGER_FOR_KEY(self.associationedNumber, @"count")
    }
    return self;
}
@end
