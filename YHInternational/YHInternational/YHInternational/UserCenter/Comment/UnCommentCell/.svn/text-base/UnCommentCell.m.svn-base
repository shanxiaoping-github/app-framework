//
//  UnCommentCell.m
//  YHInternational
//
//  Created by Holyjoy on 15/4/28.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "UnCommentCell.h"
#import "UIImage+Stretch.h"

@implementation UnCommentCell

- (void)awakeFromNib {
    _goCommentImageView.image = [[UIImage imageNamed:@"去评论按钮"] resizableImageWithCapInsets:UIEdgeInsetsMake(2, 2, 2, 2) resizingMode:UIImageResizingModeStretch];
//    _bgImageView.image = [[UIImage imageNamed:@"提醒去评论背景"] resizableImageWithCapInsets:UIEdgeInsetsMake(2, 16, 2, 2) resizingMode:UIImageResizingModeStretch];
//    _bgImageView.highlightedImage = [[UIImage imageNamed:@"提醒去评论背景"] resizableImageWithCapInsets:UIEdgeInsetsMake(2, 16, 2, 2) resizingMode:UIImageResizingModeStretch];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)didClickedBtn:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(didClickedShowGoodsBtn)]) {
        [self.delegate didClickedShowGoodsBtn];
    }  
}

@end
