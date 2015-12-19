//
//  BBGMenuItemView.m
//  BBGMenuNavigationView
//
//  Created by 程伟 on 13-10-10.
//  Copyright (c) 2013年 程伟. All rights reserved.
//

#import "BBGMenuItemView.h"
#import <QuartzCore/QuartzCore.h>
#import "NSString+TitleSize.h"
#import "BBGMacro.h"
@implementation BBGMenuItemView
@synthesize selected = _selected;

- (id)initWithFrame:(CGRect)frame itemTitle:(NSString *)title {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        _itemViewFoucusColor = [UIColor whiteColor];
        _itemViewCommonColor = [UIColor grayColor];
        _itemViewFocusFont = APP_FONT_DEMI_LIGHT(17);
        _itemViewCommonFont = APP_FONT(15);
        _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = self.itemViewCommonColor;
        _titleLabel.font = self.itemViewCommonFont;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.text = title;
        _backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
        _backgroundView.backgroundColor = [UIColor clearColor];
        [self addSubview:_backgroundView];
        [self addSubview:_titleLabel];
    }
    return self;
}

- (void)setItemViewFocusFont:(UIFont *)itemViewFocusFont {
    _itemViewFocusFont = itemViewFocusFont;
    CGSize commonTextSize = [self.titleLabel.text sizeWithStringFont:_itemViewCommonFont constrainedToSize:CGSizeMake(MAXFLOAT, self.titleLabel.frame.size.height)];
    CGSize focusTextSize = [self.titleLabel.text sizeWithStringFont:_itemViewFocusFont constrainedToSize:CGSizeMake(MAXFLOAT, self.titleLabel.frame.size.height)];
    CGSize textSize = commonTextSize.width > focusTextSize.width ? commonTextSize : focusTextSize;
    textSize.width += 10.0;
    if (self.frame.size.width < textSize.width) {
        CGRect myFrame = self.frame;
        myFrame.size.width = textSize.width;
        self.frame = myFrame;
        CGRect labelFrame = self.titleLabel.frame;
        labelFrame.size.width = textSize.width;
        self.titleLabel.frame = labelFrame;
    }
}

- (void)setItemViewCommonFont:(UIFont *)itemViewCommonFont {
    _itemViewCommonFont = itemViewCommonFont;
    CGSize commonTextSize = [self.titleLabel.text sizeWithStringFont:_itemViewCommonFont constrainedToSize:CGSizeMake(MAXFLOAT, self.titleLabel.frame.size.height)];
    CGSize focusTextSize = [self.titleLabel.text sizeWithStringFont:_itemViewFocusFont constrainedToSize:CGSizeMake(MAXFLOAT, self.titleLabel.frame.size.height)];
    CGSize textSize = commonTextSize.width > focusTextSize.width ? commonTextSize : focusTextSize;
    textSize.width += 10.0;
    if (self.frame.size.width < textSize.width) {
        CGRect myFrame = self.frame;
        myFrame.size.width = textSize.width;
        self.frame = myFrame;
        CGRect labelFrame = self.titleLabel.frame;
        labelFrame.size.width = textSize.width;
        self.titleLabel.frame = labelFrame;
    }
}

//如果想要使文字大小与控件大小相近,请调用此方法
- (void)sizeToFit {
    CGSize commonTextSize = [self.titleLabel.text sizeWithStringFont:_itemViewCommonFont constrainedToSize:CGSizeMake(MAXFLOAT, self.titleLabel.frame.size.height)];
    CGSize focusTextSize = [self.titleLabel.text sizeWithStringFont:_itemViewFocusFont constrainedToSize:CGSizeMake(MAXFLOAT, self.titleLabel.frame.size.height)];
    CGSize textSize = commonTextSize.width > focusTextSize.width ? commonTextSize : focusTextSize;
    textSize.width += 10.0;
    CGRect myFrame = self.frame;
    myFrame.size.width = textSize.width;
    self.frame = myFrame;
    CGRect labelFrame = self.titleLabel.frame;
    labelFrame.size.width = textSize.width;
    self.titleLabel.frame = labelFrame;
}

- (void)select:(BOOL)selected Animated:(BOOL)animated {
    _selected = selected;
    if (_selected) {
        _titleLabel.textColor = self.itemViewFoucusColor;
        _titleLabel.font = self.itemViewFocusFont;
        _backgroundView.hidden = NO;
        if (animated) {
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
            animation.duration = 0.5;
            animation.delegate = self;
            animation.removedOnCompletion = YES;
            animation.fillMode = kCAFillModeForwards;
            NSMutableArray *values = [NSMutableArray array];
            [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8, 0.8, 1.0)]];
            [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
            [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
            [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
            animation.values = values;
            [_titleLabel.layer addAnimation:animation forKey:nil];
        }
    } else {
        _backgroundView.hidden = YES;
        _titleLabel.textColor = self.itemViewCommonColor;
        _titleLabel.font = self.itemViewCommonFont;
    }
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    if (_selected) {
        _backgroundView.hidden = NO;
        _titleLabel.textColor = self.itemViewFoucusColor;
        _titleLabel.font = self.itemViewFocusFont;
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        animation.duration = 0.5;
        animation.delegate = self;
        animation.removedOnCompletion = YES;
        animation.fillMode = kCAFillModeForwards;
        NSMutableArray *values = [NSMutableArray array];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8, 0.8, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
        animation.values = values;
        [_titleLabel.layer addAnimation:animation forKey:nil];
    } else {
        _titleLabel.textColor = self.itemViewCommonColor;
        _titleLabel.font = self.itemViewCommonFont;
        _backgroundView.hidden = YES;
    }
}

-(void)setBadgeCount:(NSInteger)badgeCount{

    if (badgeCount>0) {
        
        if (!self.badgeView) {
            _badgeView = [[BBGBadgeView alloc] initWithBackgroundImage:[UIImage imageNamed:@"universalBadge"]];
            [self addSubview:_badgeView];
        }
        self.badgeView.hidden = NO;
        self.badgeView.number = badgeCount;
        CGRect frame = self.badgeView.frame;
        frame.origin.x = self.frame.size.width - frame.size.width;
        frame.origin.y = 2;
        self.badgeView.frame = frame;
        
    }else{
        
        if (self.badgeView) {
            self.badgeView.hidden = YES;
        }
    }

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
