//
//  BBGMyCommentTextCell.m
//  YHInternational
//
//  Created by Holyjoy on 15/4/24.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGMyCommentTextCell.h"
#import "UIImage+Stretch.h"

@implementation BBGMyCommentTextCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _bgImageView.image = [[UIImage imageNamed:@"三个描边"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1,1) resizingMode:UIImageResizingModeStretch];
    _bgImageView.highlightedImage = [[UIImage imageNamed:@"三个描边-点击反馈"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1,1) resizingMode:UIImageResizingModeStretch];
    _commentImageView.layer.cornerRadius = _commentImageView.frame.size.width/2;
    _commentImageView.layer.masksToBounds = YES;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
//    if (selected) {
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
//    }else{
//        self.selectionStyle = UITableViewCellSelectionStyleGray;
//        
//    }
}

+ (CGFloat)cellHeignt:(BBGComment *)comment{
    
    CGSize size1 = [comment.commentText
                    sizeWithStringFont:APP_FONT(14.0) constrainedToSize:CGSizeMake(IPHONE_WIDTH-99-20, 10000) lineSpacing:8];
    
    return size1.height + 47;
}

- (void)updateCell:(BBGComment *)comment{
    [_commentImageView sd_setImageWithURL:[NSURL URLWithString:comment.profileImgUrl] placeholderImage:[UIImage imageNamed:@"头像默认"]];
    if ([comment.hasOrder isEqualToString:@"true"]) {
        _buyImageView.image = [UIImage imageNamed:@"已购买标签"];
    }else{
        _buyImageView.image = nil;
    }
//    _isESC = YES;
    if (comment.isESC) {
        _commentNameLabel.textColor = UIColorFromHexadecimalRGB(0xf8718c);
        _buyImageView.image = [UIImage imageNamed:@"ESC"];
    }
    
    _commentNameLabel.text = comment.nickName;
    _commentTimeLabel.text = comment.commentTime;
    _commentLabel.text = comment.commentText;
    if (comment) {
        NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:comment.commentText];
        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle1 setLineSpacing:8];
        [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [comment.commentText length])];
        [_commentLabel setAttributedText:attributedString1];
        [_commentLabel sizeToFit];
    }
    
}

@end
