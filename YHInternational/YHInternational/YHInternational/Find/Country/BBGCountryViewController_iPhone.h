//
//  BBGCountryViewController_iPhone.h
//  YHInternational
//
//  Created by Holyjoy on 15/5/18.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGCountryViewController.h"
#import "BBGContentProtocol.h"


@interface BBGCountryViewController_iPhone : BBGCountryViewController<BBGContentProtocol>


@property (nonatomic,strong) NSMutableArray *countryArray;
@property (nonatomic,weak)UINavigationController *contentViewController;

@end
