//
//  BBGOrderDetailAddressCell_iPhone.m
//  YHInternational
//
//  Created by elvis.peng on 15-5-14.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGOrderDetailAddressCell_iPhone.h"
@interface BBGOrderDetailAddressCell_iPhone()
@property (strong, nonatomic) IBOutlet UILabel *addressLbl;
@end

@implementation BBGOrderDetailAddressCell_iPhone

- (void)awakeFromNib {
    // Initialization code
}

+(CGFloat)cellHeightWithContent:(NSString *)content maxWidth:(float)maxWidth{
    CGFloat rowHeight = 80;
    CGFloat defaultLblHeight = 41;
    CGSize size = [content sizeWithStringFont:APP_FONT(14) constrainedToSize:CGSizeMake(maxWidth-20, MAXFLOAT)];
    if (size.height>defaultLblHeight) {
        rowHeight = rowHeight + (size.height - defaultLblHeight);
    }
    return rowHeight;
}
-(void)updateAddressCellWithAddress:(NSString *)address{
    self.addressLbl.text = address;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
