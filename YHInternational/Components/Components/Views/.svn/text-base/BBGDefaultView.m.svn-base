//
//  BBGDefaultView.m
//  Components
//
//  Created by Damon on 15/4/20.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGDefaultView.h"
#import "NSString+TitleSize.h"
#import "BBGMacro.h"
@implementation BBGDefaultView

- (void)awakeFromNib{
    [super awakeFromNib];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithStampImage:(UIImage *)image
                    tips:(NSString *)tips
                  target:(id)target
                  action:(SEL)action
             actionTitle:(NSString *)actionTitle {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.backgroundColor = UIColorFromRGB(236, 235, 232);
        CGFloat startY = 95;
        UIImageView *stampImageView = [[UIImageView alloc] initWithImage:image];
        CGRect sFrame = stampImageView.frame;
        sFrame.origin.x = (self.frame.size.width - sFrame.size.width) / 2;
        sFrame.origin.y = startY;
        stampImageView.frame = sFrame;
        [self addSubview:stampImageView];
        
        startY += sFrame.size.height;
        startY += 10;
        
        CGFloat width = 230;
        UIFont *font = APP_FONT(14);
        CGSize tipsSize = [tips sizeWithStringFont:font constrainedToSize:CGSizeMake(width, MAXFLOAT)];
        UILabel *tipslabel = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width - width) / 2, startY, width, tipsSize.height)];
        tipslabel.backgroundColor = [UIColor clearColor];
        tipslabel.numberOfLines = 0;
        tipslabel.textColor = [UIColor colorWithRed:102.0 / 255 green:102.0 / 255 blue:102.0 / 255 alpha:1.0];
        tipslabel.textAlignment = NSTextAlignmentCenter;
        tipslabel.font = font;
        tipslabel.text = tips;
        [self addSubview:tipslabel];
        
        if (target && action) {
            startY += tipslabel.frame.size.height;
            startY += 10;
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.backgroundColor = [UIColor whiteColor];
            [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
            UIFont *titleFont = APP_FONT(15);
            CGSize titleSize = [actionTitle sizeWithStringFont:titleFont];
            button.titleLabel.font = titleFont;
            [button setTitleColor:[UIColor colorWithRed:51.0 / 255 green:51.0 / 255 blue:51.0 / 255 alpha:1.0] forState:UIControlStateNormal];
            [button setTitle:actionTitle forState:UIControlStateNormal];
            CGRect bFrame = button.frame;
            bFrame.size.width = titleSize.width + 40;
            bFrame.size.height = 45;
            bFrame.origin.x = (self.frame.size.width - bFrame.size.width) / 2;
            bFrame.origin.y = startY;
            button.frame = bFrame;
            UIImage *normalImage = [UIImage imageNamed:@"universalBtOneNormal"];
            [button setBackgroundImage:[normalImage stretchableImageWithLeftCapWidth:normalImage.size.width / 3 topCapHeight:normalImage.size.height / 3] forState:UIControlStateNormal];
            UIImage *highlightedImage = [UIImage imageNamed:@"universalBtOneHighlighted"];
            [button setBackgroundImage:[highlightedImage stretchableImageWithLeftCapWidth:highlightedImage.size.width / 3 topCapHeight:highlightedImage.size.height / 3] forState:UIControlStateHighlighted];
            [self addSubview:button];
        }
    }
    return self;
}

- (void)showOnView:(UIView *)view {
    [view addSubview:self];
}

- (void)showFromView:(UIView *)view {
    UIView *supView = view.superview;
    if (supView) {
        CGRect frame = self.frame;
        frame.origin.y = view.frame.origin.y + view.frame.size.height;
        self.frame = frame;
        [supView addSubview:self];
    }
}



- (void)dismiss {
    [self removeFromSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
