//
//  BBGReasonViewController_iPhone.h
//  BuBuGao
//
//  Created by elvis.peng on 14-8-27.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import "BBGViewController.h"
typedef void (^ReasonSelected)(NSString *reason);
@interface BBGReasonViewController_iPhone : BBGViewController
@property (nonatomic, copy) ReasonSelected reasonCallback;
@property (nonatomic, strong) NSArray *reasons;
- (void)show;
- (void)dismiss;
@end
