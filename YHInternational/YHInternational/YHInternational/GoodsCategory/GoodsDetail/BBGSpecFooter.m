//
//  BBGSpecFooter.m
//  YHInternational
//
//  Created by 彭腾 on 15/8/17.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGSpecFooter.h"

@implementation BBGSpecFooter

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _bottomBorder = [CALayer layer];
        _bottomBorder.frame = CGRectMake(10.0f, self.frame.size.height-0.5f, IPHONE_WIDTH-20.0f, 0.5f);
        _bottomBorder.backgroundColor = [UIColorFromHexadecimalRGB(0xe5e5e5) CGColor];
        [self.layer addSublayer:_bottomBorder];
    }
    return self;
}

@end
