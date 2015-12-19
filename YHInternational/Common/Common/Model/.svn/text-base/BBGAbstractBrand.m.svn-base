//
//  BBGAbstractBrand.m
//  Common
//
//  Created by OuyangTimmy on 15/7/21.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGAbstractBrand.h"
#import "BBGPopularBrand.h"

@implementation BBGAbstractBrand

- (id)initWithHandler:(BBGResponseDataHandler *)handler responseData:(BBGResponseData *)responseData {
    self = [super initWithHandler:handler responseData:responseData];
    if (self) {
        if (self.isError) {
            return self;
        }
        STRING_FOR_KEY(self.brandOutName, @"brandOutName")
        STRING_FOR_KEY(self.brandOutUrl, @"brandOutUrl")
        STRING_FOR_KEY(self.brandOutId, @"brandOutId")
        STRING_FOR_KEY(self.brandName, @"brandOutName")
        
        BBGResponseData *brandsData;
        DATA_FOR_KEY(brandsData, @"subBrands")
        NSInteger brandCount = brandsData.count;
        NSMutableArray *brandsList = [NSMutableArray array];

        for (int i = 0; i<brandCount; i++) {
            BBGResponseData *brandData;
            DATA_FOR_INDEX_DATA(brandData, i, brandsData)
            BBGPopularBrand *brand = [[BBGPopularBrand alloc] initWithHandler:self responseData:brandData];
            [brandsList addObject:brand];
        }
        self.subContentsArray = brandsList;

    }
    return self;
}
@end