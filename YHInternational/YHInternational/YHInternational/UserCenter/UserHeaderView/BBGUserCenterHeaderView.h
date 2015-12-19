//
//  BBGUserCenterHeaderView.h
//  YHInternational
//
//  Created by yangjie on 15/5/8.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBGBadgeView.h"
#import "BBGLineTextField.h"

@protocol BBGUserCenterMenuViewDelegate;

@interface BBGUserCenterHeaderView : UIView

@property (nonatomic,strong)UIImageView *bgImgView;
@property (nonatomic,strong)UIView *userHeadBgView;
@property (nonatomic,strong)UIButton *userHeadImage;

@property (nonatomic,strong)BBGLineTextField *nameTextField;

@property (nonatomic,strong)BBGBadgeView *unPayBadgeView;
@property (nonatomic,strong)BBGBadgeView *unSendBadgeView;
@property (nonatomic,strong)BBGBadgeView *unReceiptBadgeView;
@property (nonatomic,strong)BBGBadgeView *receiptBadgeView;
@property (nonatomic,strong)BBGBadgeView *unFinishBadgeView;

@property (nonatomic, assign) id<BBGUserCenterMenuViewDelegate> delegate;

@end


@protocol BBGUserCenterMenuViewDelegate <NSObject>

- (void)chooseUserIcons;
- (void)menuItemSelected:(BBGUserCenterHeaderView *)menuView atIndex:(NSInteger)index;
@end
