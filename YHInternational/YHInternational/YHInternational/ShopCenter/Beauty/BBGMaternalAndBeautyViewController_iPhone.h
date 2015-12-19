//
//  MaternalAndBeautyViewController_iPhone.h
//  YHInternational
//
//  Created by 刘薇 on 15/7/13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGMaternalAndBeautyViewController.h"
#import "BBGChannelViewController_iPhone.h"
@interface BBGMaternalAndBeautyViewController_iPhone : BBGMaternalAndBeautyViewController<BBGContentProtocol>
@property (nonatomic,weak)UINavigationController *contentViewController;
- (id)initWithTypeTag:(NSInteger)tag;
@end
