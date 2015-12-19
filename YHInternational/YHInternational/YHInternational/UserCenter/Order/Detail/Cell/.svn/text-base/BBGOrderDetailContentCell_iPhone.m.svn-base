//
//  BBGOrderDetailContentCell_iPhone.m
//  YHInternational
//
//  Created by elvis.peng on 15-5-13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGOrderDetailContentCell_iPhone.h"

@implementation BBGOrderDetailContentCell_iPhone

- (void)awakeFromNib {
    // Initialization code
}

+(CGFloat)cellHeightWithContent:(NSString *)content maxWidth:(float)maxWidth{
    CGFloat height = 40;
    CGSize size = [content sizeWithStringFont:APP_FONT(14) constrainedToSize:CGSizeMake(maxWidth-20, MAXFLOAT)];
    if (size.height>height) {
        height = size.height;
    }
    return height;
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
