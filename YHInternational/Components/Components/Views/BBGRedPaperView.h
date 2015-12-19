//
//  BBGRedPaperView.h
//  YHInternational
//
//  Created by 彭腾 on 15/5/22.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBGShareModel.h"

typedef void(^CancelButton)();
typedef void(^ShareButton)();

@interface BBGRedPaperView : UIView

- (void)sendShareUrl:(NSString *)shareUrl
                  ad:(NSString *)ad
              statue:(BOOL)note ;
@property (strong, nonatomic) IBOutlet UIButton *share;
@property (strong, nonatomic) IBOutlet UIButton *bigShare;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UIButton *cancel;
@property (nonatomic, copy) CancelButton button;
@property (nonatomic, copy) ShareButton shareBtn;
- (void)handlerButtonAction:(CancelButton)block;
- (void)shareButtionAction:(ShareButton)block;

+ (void)showWithUrl:(NSString *)shareUrl ad:(NSString *)ad statue:(BOOL)statue view:(UIView *)superview handler:(ShareButton)block;
+ (void)showWithModel:(BBGShareModel *)model statue:(BOOL)statue;

@end
