//
//  BBGTextLinkLabel.m
//  BubuGao
//
//  Created by calvin on 14-4-10.
//  Copyright (c) 2014年 bubugao. All rights reserved.
//

#import "BBGTextLinkLabel.h"

@implementation BBGTextLinkLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _linkColor = [UIColor grayColor];
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    _linkColor = [UIColor grayColor];
    self.clipsToBounds = YES;
}


- (void)setText:(NSString *)text {
    [super setText:text];
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [super drawRect:rect];
    CGSize textSize = CGSizeZero;
    if ([self.text respondsToSelector:@selector(sizeWithAttributes:)]) {
        textSize = [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}];
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        textSize = [self.text sizeWithFont:self.font];
#pragma clang diagnostic pop
    }
    CGSize labelSize = self.frame.size;
    CGFloat startX = 0.0;
    CGFloat startY = labelSize.height / 2.0;
    switch (self.textAlignment) {
        case NSTextAlignmentCenter:
        {
            startX = (labelSize.width - textSize.width) / 2.0;
        }
            break;
        case NSTextAlignmentRight:
        {
            startX = labelSize.width - textSize.width;
        }
            break;
        default:
        {
            startX = 0.0;
        }
            break;
    }
    CGFloat length = textSize.width;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, _linkColor.CGColor);
    CGContextSetLineWidth(context, 0.5);
    CGContextMoveToPoint(context, startX, startY);
    CGContextAddLineToPoint(context, startX + length, startY);
    CGContextStrokePath(context);
}

@end
