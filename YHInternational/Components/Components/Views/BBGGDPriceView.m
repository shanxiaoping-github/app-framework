//
//  BBGGDPriceView.m
//  Components
//
//  Created by 彭腾 on 15/10/14.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGDPriceView.h"
#import "Common.h"

@interface BBGGDPriceView ()

@property (nonatomic, strong) UILabel *crossLabel;

@property (nonatomic, strong) UILabel *unCrossLabel;

@property (nonatomic, strong) CALayer *border;

@end

@implementation BBGGDPriceView

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
    self.crossLabel = [UILabel new];
    self.unCrossLabel = [UILabel new];
    self.border = [CALayer layer];
    [self addSubview:self.crossLabel];
    [self addSubview:self.unCrossLabel];
    [self.layer addSublayer:self.border];
}

- (void)setCrossPrice:(NSString *)crossPrice {
    _crossPrice = crossPrice;
    if (_crossPrice!=nil) {
        [self initText];
    }
}

- (void)setUnCrossPrice:(NSString *)unCrossPrice {
    _unCrossPrice = unCrossPrice;
    if (_unCrossPrice!=nil) {
        [self initText];
    }
}

- (void)initText {
    self.unCrossLabel.font = APP_FONT_DEMI_LIGHT(18.0f);
    self.unCrossLabel.textColor = UICOLOR_FONT_IMPORTANT_RED;
    self.crossLabel.font = APP_FONT_DEMI_LIGHT(12.0f);
    self.crossLabel.textColor = UIColorFromHexadecimalRGB(0xcccccc);
    self.border.backgroundColor = UIColorFromHexadecimalRGB(0xcccccc).CGColor;
    
    NSString *unPrice = [NSString stringWithFormat:@"￥%.2f",[_unCrossPrice integerValue]/100.0];
    NSString *price = [NSString stringWithFormat:@"￥%.2f",[_crossPrice integerValue]/100.0];
    
    self.unCrossLabel.text = unPrice;
    [self.unCrossLabel sizeToFit];
    CGRect frame = self.unCrossLabel.frame;
    frame.origin.y = 5.0f;
    self.unCrossLabel.frame = frame;
    
    if (_crossPrice!=nil) {
        self.crossLabel.frame = CGRectMake(self.unCrossLabel.frame.origin.x+5.0f, self.unCrossLabel.frame.origin.y+self.unCrossLabel.frame.size.height+2.0f, self.frame.size.width, 0);
        self.crossLabel.text = price;
        [self.crossLabel sizeToFit];
        self.border.frame = CGRectMake(self.crossLabel.frame.origin.x, self.crossLabel.frame.origin.y+self.crossLabel.frame.size.height/2, self.crossLabel.frame.size.width, 0.5f);
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
