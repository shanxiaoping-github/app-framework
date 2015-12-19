//
//  BBGPhraseAssociationResponse.m
//  Common
//
//  Created by Holyjoy on 15/3/23.
//  Copyright (c) 2015年 BuBuGao. All rights reserved.
//

#import "BBGPhraseAssociationResponse.h"

@implementation BBGPhraseAssociationResponse

- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format {
    
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
//            return self;
        }
        BBGResponseData *phraseAssociationData;
        DATA_FOR_KEY(phraseAssociationData, @"data")
        NSInteger phraseAssociationCount = [phraseAssociationData count];
        NSMutableArray *phraseAssociationArr = [NSMutableArray arrayWithCapacity:phraseAssociationCount];
        
        for (int i = 0; i < phraseAssociationCount; i++) {
            BBGResponseData *phrase;
            DATA_FOR_INDEX_DATA(phrase, i, phraseAssociationData)
            BBGPhraseAssociation *phraseAssociation = [[BBGPhraseAssociation alloc] initWithHandler:self responseData:phrase];
            [phraseAssociationArr addObject:phraseAssociation];
        }
        self.phraseAssociationArray = phraseAssociationArr;
    }
    return self;
}
@end
