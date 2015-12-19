//
//  BBGLineTextField.m
//  demo
//
//  Created by yangjie on 15/6/1.
//  Copyright (c) 2015年 a. All rights reserved.
//

#import "BBGLineTextField.h"
#import "Common.h"

@implementation BBGLineTextField

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setClipsToBounds:NO];
        _lineLayer = [[CALayer alloc] init];
        [_lineLayer setBackgroundColor:[UIColor whiteColor].CGColor];
        [_lineLayer setFrame:CGRectMake(0, FRAMEH(self)-1, 10, 1)];
        _lineLayer.position = CGPointMake(FRAMEW(self)/2, _lineLayer.position.y);
        [self.layer addSublayer:_lineLayer];
        
        [self addTarget:self action:@selector(changetText) forControlEvents:UIControlEventEditingChanged];
        
    }
    return self;
}

- (void)changetText{
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];

    NSString *text = self.text;
    if ([@"" isEqualToString:text] || text == nil) {
        text = self.placeholder;
    }
    CGSize size = [text sizeWithAttributes:self.defaultTextAttributes];
    CGRect rect = _lineLayer.frame;
    rect.origin.y = FRAMEH(self) - 1;
    rect.size.width = MIN(size.width+25, FRAMEW(self)+25);
    
    _lineLayer.frame = rect;
    _lineLayer.position = CGPointMake(FRAMEW(self)/2, _lineLayer.position.y);
}

@end
