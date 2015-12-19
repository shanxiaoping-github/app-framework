//
//  SearchHistoryCollectionHeadView.m
//  BuBuGao
//
//  Created by Holyjoy on 15/3/20.
//  Copyright (c) 2015年 BuBuGao. All rights reserved.
//

#import "SearchHistoryCollectionHeadView.h"

@interface SearchHistoryCollectionHeadView ()

@property (nonatomic,strong)UILabel *leftLabel;
@property (nonatomic,strong)UIButton *clearHistoyBtn;

@end

@implementation SearchHistoryCollectionHeadView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *bgView = [[UIImageView alloc] initWithFrame:self.bounds];
        bgView.image = [UIImage imageNamed:@"ClearHistoryBg"];
        [self addSubview:bgView];
        
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.frame = CGRectMake(10, 0, 200, self.frame.size.height);
        _leftLabel.text = @"本地搜索历史";
        _leftLabel.textAlignment = NSTextAlignmentLeft;
        _leftLabel.textColor = UIColorFromHexadecimalRGB(0x666666);
//        _leftLabel.font = [UIFont systemFontOfSize:13.0];
        _leftLabel.font = APP_FONT(13.0);
        [self addSubview:_leftLabel];
        
        _clearHistoyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _clearHistoyBtn.frame = CGRectMake(self.frame.size.width - 75, 0, 75, self.frame.size.height);
        [_clearHistoyBtn setTitle:@"清空" forState:UIControlStateNormal];
        [_clearHistoyBtn setTitleColor:UIColorFromHexadecimalRGB(0xf34568) forState:UIControlStateNormal];
        [_clearHistoyBtn addTarget:self action:@selector(actionOfClear:) forControlEvents:UIControlEventTouchUpInside];
        _clearHistoyBtn.titleLabel.font = APP_FONT(13.0);
//        _clearHistoyBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
        [self addSubview:_clearHistoyBtn];
        
//        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)actionOfClear:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didActionClearBtn)]) {
        [self.delegate didActionClearBtn];
    }
}

@end
