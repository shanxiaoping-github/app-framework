//
//  UMFeedbackViewController.h
//  UMeng Analysis
//
//  Created by liu yu on 7/12/12.
//  Copyright (c) 2012 Realcent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMFeedback.h"
#import "BBGViewController.h"

@interface BBGUMFeedbackViewController : BBGViewController <UMFeedbackDataDelegate> {
    UMFeedback *feedbackClient;
    BOOL _reloading;
    CGFloat _tableViewTopMargin;
    BOOL _shouldScrollToBottom;
}

@property(nonatomic, strong) BBGPullTable *mTableView;
@property(nonatomic, strong) UIView *mContactView;

@property(nonatomic, strong) NSArray *mFeedbackData;
@property(nonatomic, copy) NSString *appkey;
- (void)sendFeedback:(id)sender;
@end
