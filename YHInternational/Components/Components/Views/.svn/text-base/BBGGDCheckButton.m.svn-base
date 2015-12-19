//
//  BBGGDCheckButton.m
//  Components
//
//  Created by 彭腾 on 15/10/15.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGDCheckButton.h"
#import "Common.h"

@interface BBGGDCheckButton ()
/**
 *  圆点背景
 */
@property (nonatomic, strong) UIImageView *numBg;
/**
 *  圆点数量
 */
@property (nonatomic, strong) UILabel *numLab;
/**
 *  按钮显示文字
 */
@property (nonatomic, strong) UILabel *checkLabel;
/**
 *  按钮显示图片
 */
@property (nonatomic, strong) UIImageView *checkImage;

@end

@implementation BBGGDCheckButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(!self){
        return nil;
    }
    [self initObject];
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(!self){
        return nil;
    }
    [self initObject];
    
    return self;
}

- (void)initObject {
    self.numBg = [UIImageView new];
    self.numLab = [UILabel new];
    self.checkLabel = [UILabel new];
    self.checkImage = [UIImageView new];
    
    [self addSubview:self.checkLabel];
    [self addSubview:self.checkImage];
    [self addSubview:self.numBg];
}

- (void)setTotalType:(NSInteger)totalType {
    _totalType = totalType;
}

- (void)setIsLogin:(BOOL)isLogin {
    _isLogin = isLogin;
    [self initUI];
}

- (void)initUI {
    if (self.totalType > 0) {
        self.backgroundColor = UICOLOR_FONT_IMPORTANT_RED;
        self.layer.borderColor = [UICOLOR_FONT_IMPORTANT_RED CGColor];
    }else {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = [UIColorFromHexadecimalRGB(0xdfdfdf) CGColor];
    }
    self.layer.cornerRadius = 4.0f;
    self.layer.borderWidth = 1.0f;
    self.clipsToBounds = YES;
    
    self.checkLabel.frame = CGRectMake(5, 12, self.frame.size.width/4*2+5.0f, 20);
    self.checkLabel.text = @"去结算";
    self.checkLabel.textAlignment = NSTextAlignmentRight;
    self.checkLabel.font = APP_FONT(14.0f);
    
    if (self.totalType > 0) {
        self.checkLabel.textColor = [UIColor whiteColor];
    }else {
        self.checkLabel.textColor = UICOLOR_FONT_GENERAL_GRAY;
    }
    self.checkLabel.textAlignment = NSTextAlignmentCenter;
    
    self.checkImage.frame = CGRectMake(self.checkLabel.frame.origin.x+self.checkLabel.frame.size.width+3.0f, 12, 20, 20);
    if (self.totalType > 0) {
        [self.checkImage setImage:[UIImage imageNamed:@"shoppingCartWhite"]];
    }else {
        [self.checkImage setImage:[UIImage imageNamed:@"shoppingCartIcon"]];
    }
    
    self.numBg.frame = CGRectMake(self.checkImage.frame.origin.x+self.checkImage.frame.size.width-11, self.checkImage.frame.origin.y-4, 14, 14);
    self.numBg.backgroundColor = [UIColor whiteColor];
    self.numBg.layer.cornerRadius = self.numBg.frame.size.width/2;
    self.numBg.clipsToBounds = YES;
    
    self.numLab.frame = CGRectMake(0, 0, 14, 14);
    self.numLab.textColor = UICOLOR_FONT_IMPORTANT_RED;
    self.numLab.font = [UIFont systemFontOfSize:10.0f];
    self.numLab.textAlignment = NSTextAlignmentCenter;
    [self.numBg addSubview:self.numLab];
    
    if (self.totalType > 0) {
        self.numLab.text = [NSString stringWithFormat:@"%ld",(long)self.totalType];
        self.numLab.hidden = NO;
        self.numBg.hidden = NO;
    }else {
        self.numBg.hidden = YES;
        self.numLab.hidden = YES;
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
