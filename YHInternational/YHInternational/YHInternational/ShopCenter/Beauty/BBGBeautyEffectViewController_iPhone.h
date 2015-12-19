//
//  BeautyEffectViewController_iPhone.h
//  YHInternational
//
//  Created by 彭腾 on 15/7/9.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGBeautyEffectViewController.h"
#import "BBGChannelViewController_iPhone.h"
@interface BBGBeautyEffectViewController_iPhone : BBGBeautyEffectViewController<BBGContentProtocol>
@property (nonatomic,weak)UINavigationController *contentViewController;

@end
