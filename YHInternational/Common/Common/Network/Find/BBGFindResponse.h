//
//  BBGFindResponse.h
//  Common
//
//  Created by Holyjoy on 15/5/18.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGResponse.h"
#import "BBGFindCountry.h"
#import "BBGFindCategory.h"

@interface BBGFindResponse : BBGResponse

@property (nonatomic,strong) BBGFindCountry *findCountry;
@property (nonatomic,strong) BBGFindCategory *findCategory;
@end
