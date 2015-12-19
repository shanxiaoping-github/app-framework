//
//  BBGBadgeView.m
//  Views
//
//  Created by 程伟 on 13-10-12.
//  Copyright (c) 2013年 程伟. All rights reserved.
//

#import "BBGBadgeView.h"
#import "BBGMacro.h"
#define DEFAULTSIZE CGSizeMake(13.0, 13.0)
#define TEXTSPACE 3.0   //字体与控件两边的空隙

@interface BBGBadgeView ()

@property(nonatomic, strong) UIImageView *backgroundImageView;
@property(nonatomic, strong) UILabel *textLabel;

@end

@implementation BBGBadgeView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //Initialization code
        self.backgroundColor = [UIColor clearColor];
        frame.size = DEFAULTSIZE;
        self.frame = frame;
        self.autoresizingMask = UIViewAutoresizingNone;
        self.userInteractionEnabled = NO;
        self.backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.backgroundImageView.image = self.backgroundImage;
        [self addSubview:self.backgroundImageView];
        self.textColor = [UIColor whiteColor];
        self.textLabel = [[UILabel alloc] initWithFrame:self.bounds];
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.textColor = self.textColor;
        self.textLabel.font = APP_FONT(10);
        [self addSubview:self.textLabel];
        self.number = 0;
    }
    return self;
}

- (id)initWithBackgroundImage:(UIImage *)image {
    self = [super initWithFrame:CGRectMake(0, 0, DEFAULTSIZE.width, DEFAULTSIZE.height)];
    if (self) {
        //Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.autoresizingMask = UIViewAutoresizingNone;
        self.userInteractionEnabled = NO;
        self.backgroundImage = image;
        self.backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.backgroundImageView.image = self.backgroundImage;
        [self addSubview:self.backgroundImageView];
        self.textColor = [UIColor whiteColor];
        self.textLabel = [[UILabel alloc] initWithFrame:self.bounds];
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.textColor = self.textColor;
        self.textLabel.font = APP_FONT(10);
        [self addSubview:self.textLabel];
        self.number = 0;
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    frame.size.height = DEFAULTSIZE.height;
    [super setFrame:frame];
}

- (void)setAutoresizingMask:(UIViewAutoresizing)autoresizingMask {
    [super setAutoresizingMask:UIViewAutoresizingNone];
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    _textLabel.textColor = _textColor;
}

- (void)setNumber:(NSInteger)number {
    [self setNumber:number prefix:nil];
    _number = number;
}

- (void)setNumber:(NSInteger)number prefix:(NSString *)prefix{
    self.hidden = number == 0;
    NSString *text = @"";
    if (number>99) {
        if (prefix) {
            text = [NSString stringWithFormat:@"%@99+",prefix];
        }else{
            text = [NSString stringWithFormat:@"99+"];
        }
    }else if(number == -1){
        text = prefix;
    }else{
        if (prefix) {
            text = [NSString stringWithFormat:@"%@%ld",prefix,(long)number];
        }else{
            text = [NSString stringWithFormat:@"%ld", (long)number];
        }
        
    }
    
    CGSize textSize = CGSizeZero;
    if ([text respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        textSize = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, _textLabel.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_textLabel.font} context:nil].size;
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        textSize = [text sizeWithFont:self.textLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, self.textLabel.frame.size.height) lineBreakMode:self.textLabel.lineBreakMode];
#pragma clang diagnostic pop
    }
    if (textSize.width + 2 * TEXTSPACE > DEFAULTSIZE.width) {
        CGRect frame = self.frame;
        frame.size.width = textSize.width + 2 * TEXTSPACE;
        self.frame = frame;
        self.backgroundImageView.frame = self.bounds;
        self.backgroundImageView.image = [self.backgroundImage stretchableImageWithLeftCapWidth:(self.backgroundImage.size.width - 1) / 2.0 topCapHeight:0];
        self.textLabel.frame = CGRectMake(0, -0.5, self.bounds.size.width, self.bounds.size.height);
    }else{
        CGRect frame = self.frame;
        frame.size.width = DEFAULTSIZE.width;
        self.frame = frame;
        self.backgroundImageView.frame = self.bounds;
        self.backgroundImageView.image = self.backgroundImage;
        self.textLabel.frame = CGRectMake(0, -0.5, self.bounds.size.width, self.bounds.size.height);
    }
    _number = number;
    self.textLabel.text = text;

}


- (void)setBackgroundImage:(UIImage *)backgroundImage {
    _backgroundImage = backgroundImage;
    self.backgroundImageView.image = [self.backgroundImage stretchableImageWithLeftCapWidth:(self.backgroundImage.size.width - 1) / 2.0 topCapHeight:0];
}


@end
