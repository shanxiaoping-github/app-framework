//
//  BBGPayTypeResponse.m
//  Common
//
//  Created by elvis.peng on 15-5-18.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGPayTypeResponse.h"

@implementation BBGPayTypeResponse
- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format{
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
        BBGResponseData *data;
        DATA_FOR_KEY(data, @"data");
        
        if (data && [data count]>0) {
            
            self.payTypeList = [NSMutableArray arrayWithCapacity:[data count]];
            for (int i =0; i<[data count]; i++) {
                
                BBGResponseData *payTypeData;
                DATA_FOR_INDEX_DATA(payTypeData, i, data);
                BBGPayType *payType = [[BBGPayType alloc] initWithHandler:self responseData:payTypeData];
                [self.payTypeList addObject:payType];
            }
        }
       
    }
    return self;
}
@end
