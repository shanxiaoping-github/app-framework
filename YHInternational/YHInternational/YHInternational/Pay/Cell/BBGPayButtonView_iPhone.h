//
//  BBGPayButtonView_iPhone.h
//  YHInternational
//
//  Created by elvis.peng on 15-5-15.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Common/Common.h>
#define BUTTONWIDTH 80
#define BUTTONHEIGHT 85

@class BBGPayButtonView_iPhone;
@protocol BBGPayButtonViewDelegate <NSObject>
- (void)payButtonDidChange:(BBGPayType *)payType;
@end
@interface BBGPayButtonView_iPhone : UIView
@property (nonatomic,weak)id<BBGPayButtonViewDelegate> delegate;
@property (nonatomic,assign)BOOL isSelected;
-(void)updatePayButtonViewWithPayType:(BBGPayType *)payType selectedPayType:(BBGPayType *)selectedPayType;
@end
