//
//  BBGGSTitleCell.m
//  YHInternational
//
//  Created by 彭腾 on 15/10/14.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGSTitleCell.h"

@interface BBGGSTitleCell ()
@property (strong, nonatomic) IBOutlet UILabel *titleLab;

@end

@implementation BBGGSTitleCell

- (void)updateCellWith:(BBGGoodsBasicInfo *)goodsBasicInfo {
    self.titleLab.numberOfLines = 0;
    NSString *string = goodsBasicInfo.productName;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:5.0f];
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [string length])];
    self.titleLab.attributedText = attributedString;
}

+ (CGFloat)cellHeight:(BBGGoodsBasicInfo *)goodsBasicInfo {
    NSString *string = goodsBasicInfo.productName;
    CGSize size = [string sizeWithStringFont:APP_FONT(13.0f) constrainedToSize:CGSizeMake(IPHONE_WIDTH-20, 100000) lineSpacing:5.0f];
    if (size.height>20.0f) {
        return size.height+20.0f+25.0f;
    }else {
        return 45.0f;
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
