//
//  BBGFoldableFunctionCell_iPhone.m
//  YHInternational
//
//  Created by OuyangTimmy on 15/7/9.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGFoldableFunctionCell_iPhone.h"

@implementation BBGFoldableFunctionCell_iPhone

- (void)awakeFromNib {
    // Initialization code
    UIControl *control = [[UIControl alloc] initWithFrame:self.bounds];
    [control addTarget:self action:@selector(didSelect:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:control];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (float)cellHeight {

    return 38;
}

- (void)didSelect:(UIControl *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(foldableCell:didSelectAtIndexPath:)]) {
        [self.delegate foldableCell:self didSelectAtIndexPath:self.indexPath];
    }

}

@end
