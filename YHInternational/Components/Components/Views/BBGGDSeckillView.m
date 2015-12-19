//
//  BBGGDSeckillView.m
//  Components
//
//  Created by 彭腾 on 15/10/15.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGDSeckillView.h"
#import "Common.h"

@interface BBGGDSeckillView ()

@property (nonatomic, strong) CALayer *topLayer;

@property (nonatomic, strong) CALayer *bottomLayer;

@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, strong) UIImageView *arrowImageView;

@end

@implementation BBGGDSeckillView

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
    self.topLayer = [CALayer layer];
    self.bottomLayer = [CALayer layer];
    self.textLabel = [UILabel new];
    self.arrowImageView = [UIImageView new];
    [self.layer addSublayer:self.topLayer];
    [self.layer addSublayer:self.bottomLayer];
    [self addSubview:self.textLabel];
    [self addSubview:self.arrowImageView];
}

- (void)setSeckillActity:(BOOL)seckillActity {
    _seckillActity = seckillActity;
    if (!seckillActity) {
        self.hidden = YES;
    }else {
        self.hidden = NO;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundColor = UIColorFromHexadecimalRGB(0xffedf2);
    self.alpha = 0.9f;
    self.topLayer.backgroundColor = UICOLOR_FONT_IMPORTANT_RED.CGColor;
    self.topLayer.frame = CGRectMake(0, 0, self.frame.size.width, 0.5f);
    self.bottomLayer.backgroundColor = UICOLOR_FONT_IMPORTANT_RED.CGColor;
    self.bottomLayer.frame = CGRectMake(0, self.frame.size.height-0.5f, self.frame.size.width, 0.5f);
    self.textLabel.text = @"该商品正在参与秒杀活动，立即秒杀";
    self.textLabel.font = APP_FONT(14.0f);
    self.textLabel.textColor = UICOLOR_FONT_IMPORTANT_RED;
    [self.textLabel sizeToFit];
    CGRect frame = self.textLabel.frame;
    frame.origin.y = (self.frame.size.height-frame.size.height)/2;
    frame.origin.x = (self.frame.size.width-frame.size.width)/2;
    self.textLabel.frame = frame;
    self.arrowImageView.frame = CGRectMake(self.textLabel.frame.origin.x+self.textLabel.frame.size.width+5.0f, (self.frame.size.height-10.0f)/2, 10.0f, 10.0f);
    [self.arrowImageView setImage:[UIImage imageNamed:@"gd_seckillarrow"]];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
