//
//  SearchHistoryCollectionViewCell.m
//  BuBuGao
//
//  Created by Holyjoy on 15/3/20.
//  Copyright (c) 2015年 BuBuGao. All rights reserved.
//

#import "SearchHistoryCollectionViewCell.h"
#import "BBGMacro.h"
#import "UIImage+Stretch.h"
@implementation SearchHistoryCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if (self) {
        UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width , 35)];
        bgView.image = [[UIImage imageNamed:@"HistoryBg"] stretchImage];
        [self addSubview:bgView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 35)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = APP_FONT(13.0);
        _titleLabel.textColor = UIColorFromHexadecimalRGB(0x666666);
        [self addSubview:_titleLabel];

        self.layer.cornerRadius = 3;
        self.layer.masksToBounds = YES;

        
//        self.backgroundColor = [UIColor whiteColor];
        self.selectedBackgroundView.backgroundColor = UIColorFromHexadecimalRGB(0xe1e1e1);
        
    }
    
    return self;
}

@end
