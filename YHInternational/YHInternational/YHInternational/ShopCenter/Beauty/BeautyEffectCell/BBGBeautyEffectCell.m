//
//  BeautyEffectCell.m
//  YHInternational
//
//  Created by 彭腾 on 15/7/9.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGBeautyEffectCell.h"

@implementation BBGBeautyEffectCell

- (IBAction)click:(UIButton *)sender {
    if (self.button) {
        self.button();
    }
}

- (void)buttonAction:(buttonClick)block {
    self.button = block;
}

- (void)awakeFromNib {
    // Initialization code
}

@end
