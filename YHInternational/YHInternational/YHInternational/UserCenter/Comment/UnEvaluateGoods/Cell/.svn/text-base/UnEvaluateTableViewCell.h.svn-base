//
//  UnEvaluateTableViewCell.h
//  YHInternational
//
//  Created by Holyjoy on 15/5/19.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBGUnEvaluateGood.h"

@protocol UnEvaluateTableViewCellDelegate;

@interface UnEvaluateTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *productNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;
@property (weak, nonatomic) IBOutlet UIButton *praiseButton;
@property (weak, nonatomic) IBOutlet UIImageView *praiseHeartImg;

@property (nonatomic,weak) id<UnEvaluateTableViewCellDelegate> delegate;

- (void)reloadCell:(BBGUnEvaluateGood *)product;

@end

@protocol UnEvaluateTableViewCellDelegate <NSObject>

- (void)didClickedEvaluateGoodsBtn:(UnEvaluateTableViewCell *)cell;

@end
