//
//  PTPriceView.m
//  生鲜商品详情
//
//  Created by 彭腾 on 15/9/24.
//  Copyright (c) 2015年 彭腾. All rights reserved.
//

#import "BBGPTPriceView.h"

@interface BBGPTPriceView ()
@property (nonatomic, strong) CALayer *border;
@property (nonatomic, strong) UILabel *unCrossLabel;
@property (nonatomic, strong) UILabel *crossLabel;
@end

@implementation BBGPTPriceView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    [self initObject];
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (!self) {
        return nil;
    }
    [self initObject];
    return self;
}

- (void)initObject {
    self.unCrossLabel = [UILabel new];
    self.crossLabel = [UILabel new];
    self.border = [CALayer layer];
    [self addSubview:self.unCrossLabel];
    [self addSubview:self.crossLabel];
    [self.layer addSublayer:self.border];
}

- (void)initText {
    
    NSString *unPrice = [NSString stringWithFormat:@"￥%.2f",[_unCrossPrice integerValue]/100.0];
    NSString *price = [NSString stringWithFormat:@"￥%.1f",[_crossPrice integerValue]/100.0];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:unPrice];
    [attr addAttribute:NSFontAttributeName value:APP_FONT_DEMI_LIGHT(12.0f) range:NSMakeRange(0, unPrice.length)];
    [attr addAttribute:NSFontAttributeName value:APP_FONT_DEMI_LIGHT(17.0f) range:NSMakeRange(1, unPrice.length-3)];
    [attr addAttribute:NSForegroundColorAttributeName value:UICOLOR_FONT_IMPORTANT_RED range:NSMakeRange(0, unPrice.length)];
    self.unCrossLabel.attributedText = attr;
    [self.unCrossLabel sizeToFit];
    
    if ([_crossPrice integerValue]!=0) {
        self.crossLabel.text = price;
        self.crossLabel.textColor = UIColorFromHexadecimalRGB(0xcccccc);
        self.crossLabel.font = APP_FONT_DEMI_LIGHT(12.0f);
        [self.crossLabel sizeToFit];
        self.crossLabel.frame = CGRectMake(self.frame.size.width-self.crossLabel.frame.size.width, self.unCrossLabel.frame.origin.y+5.0f, self.crossLabel.frame.size.width, self.crossLabel.frame.size.height);
        self.border.frame = CGRectMake(self.crossLabel.frame.origin.x, self.crossLabel.frame.size.height/2+5.0f, self.crossLabel.frame.size.width, 0.5f);
    }
}

- (void)layoutSubviews {
    self.unCrossLabel.frame = self.bounds;
    self.border.backgroundColor = [UIColorFromHexadecimalRGB(0xcccccc) CGColor];
    [self initText];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
