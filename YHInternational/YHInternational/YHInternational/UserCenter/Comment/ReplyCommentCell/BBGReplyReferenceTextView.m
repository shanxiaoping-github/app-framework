//
//  BBGReplyReferenceTextView.m
//  YHInternational
//
//  Created by Holyjoy on 15/4/27.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGReplyReferenceTextView.h"

@implementation BBGReplyReferenceTextView

- (void)awakeFromNib {
    
    
}
- (void)updateCell:(BBGReply *)reply{
    _referenceName.text = reply.nickName;
    if ([reply.hasOrder isEqualToString:@"true"]) {
        _buyLabel.image = [UIImage imageNamed:@"已购买标签"];
    }else{
        _buyLabel.image = nil;
    }
    
//        _isESC = YES;
    if (reply.isESC) {
        _referenceName.textColor = UIColorFromHexadecimalRGB(0xf8718c);
        _buyLabel.image = [UIImage imageNamed:@"ESC"];
    }

    
    _referenceDate.text = reply.replyTime;
//    _referenceText.text = reply.replyText;
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:reply.replyText];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:8];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [reply.replyText length])];
    [_referenceText setAttributedText:attributedString1];
    [_referenceText sizeToFit];    
}
@end
