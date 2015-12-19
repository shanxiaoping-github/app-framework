//
//  BBGMyPraiseCell_iPhone.h
//  YHInternational
//
//  Created by BubuGao on 15-4-17.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBGPraiseProduct.h"

@protocol BBGMyPraiseCellDelegate;

@interface BBGMyPraiseCell_iPhone : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *productNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;
@property (weak, nonatomic) IBOutlet UIButton *praiseButton;
@property (weak, nonatomic) IBOutlet UIImageView *praiseHeartImg;

@property (nonatomic,weak) id<BBGMyPraiseCellDelegate> delegate;


- (void)reloadCell:(BBGPraiseProduct*)product;

@end


@protocol BBGMyPraiseCellDelegate <NSObject>

- (void)cancelPraise:(BBGMyPraiseCell_iPhone*)cell;

@end