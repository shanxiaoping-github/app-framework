//
//  BBGCosmeticBrandListResponse.m
//  Common
//
//  Created by OuyangTimmy on 15/7/21.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGCosmeticBrandListResponse.h"
#import "BBGPopularBrand.h"
#import "BBGAbstractBrand.h"

@implementation BBGCosmeticBrandListResponse

- (id)initWithData:(NSData *)data format:(ResponseDataFormat)format {
    
    self = [super initWithData:data format:format];
    if (self) {
        if (self.isError) {
            return self;
        }

        BBGResponseData *data;
        DATA_FOR_KEY(data, @"data")

        //爆款品牌
        BBGResponseData *popularBrandsData;
        DATA_FOR_KEY_DATA(popularBrandsData, @"popularBrands", data)
        NSInteger popularCount = popularBrandsData.count;
        NSMutableArray *popularList = [NSMutableArray array];
        for (int i = 0; i<popularCount; i++) {
            BBGResponseData *popularBrandData;
            DATA_FOR_INDEX_DATA(popularBrandData, i, popularBrandsData)
            BBGPopularBrand *popularBrand = [[BBGPopularBrand alloc] initWithHandler:self responseData:popularBrandData];
            popularBrand.brandType = BBGPopularBrandType;
            [popularList addObject:popularBrand];
        }
        self.popularBrands = popularList;
        
        
        //推荐品牌列表
        BBGResponseData *brandsData;
        DATA_FOR_KEY_DATA(brandsData, @"brands", data)
        NSInteger brandsCount = brandsData.count;
        NSMutableArray *brandsList = [NSMutableArray array];
        for (int i = 0; i<brandsCount; i++) {
            BBGResponseData *brandData;
            DATA_FOR_INDEX_DATA(brandData, i, brandsData)
            BBGAbstractBrand *brand = [[BBGAbstractBrand alloc] initWithHandler:self responseData:brandData];
            brand.brandType = BBGRecommendBrandType;
            [brandsList addObject:brand];
        }
        self.recommendBrands = brandsList;
    }
    return self;
}
@end
