//
//  BBGReplyImageCell.m
//  YHInternational
//
//  Created by Holyjoy on 15/4/24.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGReplyImageCell.h"
#import "UIImage+Stretch.h"


@implementation BBGReplyImageCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    _userImageView.layer.cornerRadius = _userImageView.frame.size.width/2;
    _userImageView.layer.masksToBounds = YES;

    _bgView.image = [[UIImage imageNamed:@"三个描边"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1,1) resizingMode:UIImageResizingModeStretch];
    _bgView.highlightedImage = [[UIImage imageNamed:@"三个描边-点击反馈"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1,1) resizingMode:UIImageResizingModeStretch];
    _replyReferenceImageView.bgImageView.image = [[UIImage imageNamed:@"引用背景"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 27, 2, 5) resizingMode:UIImageResizingModeStretch];
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

+ (CGFloat)cellHeignt:(BBGComment *)comment replyText:(BBGReply *)reply{
    CGSize size1 = [comment.commentText
                    sizeWithStringFont:APP_FONT(14.0) constrainedToSize:CGSizeMake(IPHONE_WIDTH-99-20, 10000) lineSpacing:8];
    CGSize size2 = [reply.replyText
                    sizeWithStringFont:APP_FONT(14.0) constrainedToSize:CGSizeMake(IPHONE_WIDTH-99-20-20, 10000) lineSpacing:8];
    
    CGFloat height = (IPHONE_WIDTH - 99 - 20 - 20)/3;
    if ([reply.imgUrlListArray count] > 3) {
        return  height*2 + size1.height + size2.height + 113;
    }else{
        return height + size1.height + size2.height + 113;
    }
    
}

- (void)updateCell:(BBGComment *)comment replyText:(BBGReply *)reply{
    
    CGSize replySize = [comment.commentText
                        sizeWithStringFont:APP_FONT(14.0) constrainedToSize:CGSizeMake(IPHONE_WIDTH-99-20, 10000) lineSpacing:8];
    _replyHeightConstrains.constant = replySize.height;
    
    [_userImageView sd_setImageWithURL:[NSURL URLWithString:comment.profileImgUrl] placeholderImage:[UIImage imageNamed:@"头像默认"]];
    
    if ([comment.hasOrder isEqualToString:@"true"]) {
        _isBuyImageView.image = [UIImage imageNamed:@"已购买标签"];
    }else{
        _isBuyImageView.image = nil;
    }
//            _isESC = YES;
    if (comment.isESC) {
        _replyNameToNameLabel.textColor = UIColorFromHexadecimalRGB(0xf8718c);
        _isBuyImageView.image = [UIImage imageNamed:@"ESC"];
    }
    
    _replyNameToNameLabel.text = comment.nickName;
    _replyDateLabel.text = comment.commentTime;
//    _replyTextLabel.text = comment.commentText;
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:comment.commentText];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:8];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [comment.commentText length])];
    [_replyTextLabel setAttributedText:attributedString1];
    [_replyTextLabel sizeToFit];
    
    [_replyReferenceImageView updateCell:reply];
    
}


@end
