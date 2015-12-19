//
//  BBGAttributedLabel.m
//  Common
//
//  Created by Timmy OuYang on 15/4/17.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGAttributedLabel.h"
#import "BBGMacro.h"

@implementation BBGAttributedLabel

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithStyle:(AttributeStyle)style
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)setNeedsDisplay {

}

- (void)updateWithStyle:(AttributeStyle)style {

    switch (style) {
            //删除线
        case UnderlineStyleSingle:
        {
            NSUInteger length = [self.text length];
            NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:self.text];
            [attributeString addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(2, length-2)];
            [attributeString addAttribute:NSStrikethroughColorAttributeName value:UIColorFromHexadecimalRGB(0x999999) range:NSMakeRange(2, length-2)];
            [self setAttributedText:attributeString];
        }
            
            break;
            //链接
        case LinkAttributeName:
        {
            NSUInteger length = [self.text length];
            NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:self.text];
            [attributeString addAttribute:NSLinkAttributeName value:self.text range:NSMakeRange(0, length)];
            [self setAttributedText:attributeString];
        }
            
            break;

        default:
            break;
    }
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self updateWithStyle:UnderlineStyleSingle];
}


@end
