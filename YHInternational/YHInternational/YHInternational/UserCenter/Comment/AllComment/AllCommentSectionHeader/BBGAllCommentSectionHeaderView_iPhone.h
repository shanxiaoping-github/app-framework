//
//  BBGAllCommentSectionHeaderView_iPhone.h
//  YHInternational
//
//  Created by Holyjoy on 15/5/6.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^tapHeaderBlock)();

@interface BBGAllCommentSectionHeaderView_iPhone : UIView
@property (strong, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (strong, nonatomic) IBOutlet UILabel *goodsDescLabel;
@property (strong, nonatomic) IBOutlet UILabel *goodsPriceLabel;
@property (nonatomic,copy) tapHeaderBlock tapBlock;

@end
