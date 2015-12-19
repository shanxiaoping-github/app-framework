//
//  BBGOrderDetailActiveCell_iPhone.m
//  YHInternational
//
//  Created by elvis.peng on 15-5-13.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGOrderDetailActiveCell_iPhone.h"
@interface BBGOrderDetailActiveCell_iPhone()


@end
@implementation BBGOrderDetailActiveCell_iPhone

- (void)awakeFromNib {
    // Initialization code
}

+(CGFloat)cellHeightWithContent:(NSString *)content{
    CGFloat rowHeight = 92;
    CGFloat defaultLblHeight = 21;
    CGSize size = [content sizeWithStringFont:APP_FONT(14) constrainedToSize:CGSizeMake(IPHONE_WIDTH-98, MAXFLOAT)];
    if (size.height>defaultLblHeight) {
        rowHeight = rowHeight + (size.height - defaultLblHeight);
    }
    return rowHeight;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
