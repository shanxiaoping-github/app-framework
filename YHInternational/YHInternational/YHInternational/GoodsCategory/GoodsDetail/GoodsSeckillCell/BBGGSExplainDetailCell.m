//
//  BBGGSExplainDetailCell.m
//  YHInternational
//
//  Created by 彭腾 on 15/10/14.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGSExplainDetailCell.h"

@interface BBGGSExplainDetailCell ()
@property (strong, nonatomic) IBOutlet UIView *dotView;
@property (strong, nonatomic) IBOutlet UILabel *label;

@end

@implementation BBGGSExplainDetailCell

- (void)awakeFromNib {
    // Initialization code
    self.dotView.layer.cornerRadius = self.dotView.frame.size.width/2;
    self.dotView.clipsToBounds = YES;
    self.label.numberOfLines = 0;
}

+ (CGFloat)cellHeight:(BBGGSSeckillModel *)model {
    NSString *string = model.desc;
    CGSize size = [string sizeWithStringFont:APP_FONT(13.0f) constrainedToSize:CGSizeMake(IPHONE_WIDTH-14, 10000)];
    return size.height + 8;
}

- (void)updateCellWith:(BBGGSSeckillModel *)seckillModel {
    self.label.text = seckillModel.desc;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
