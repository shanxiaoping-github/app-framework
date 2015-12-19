//
//  BBGFindResponse.m
//  Common
//
//  Created by Holyjoy on 15/5/18.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGFindResponse.h"


@implementation BBGFindResponse

- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format{
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }
        BBGResponseData *data;
        DATA_FOR_KEY(data, @"data")
        if (data && [data count]>0) {
            for (int i = 0; i<[data count]; i++) {
                if (i == 0) {
                    BBGResponseData *countryData;
                    DATA_FOR_INDEX_DATA(countryData, i, data)
                    _findCountry = [[BBGFindCountry alloc] initWithHandler:self responseData:countryData];
                }else if(i == 1) {
                    BBGResponseData *categoryData;
                    DATA_FOR_INDEX_DATA(categoryData, i, data)
                    _findCategory = [[BBGFindCategory alloc] initWithHandler:self responseData:categoryData];
                }
                
            }
        }
    }
    return self;
}


@end
