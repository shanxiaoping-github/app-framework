//
//  BBGGDBuyButton.m
//  Components
//
//  Created by 彭腾 on 15/10/15.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGDBuyButton.h"
#import "Common.h"

@interface BBGGDBuyButton ()
/**
 *  按钮显示图片
 */
@property (nonatomic, strong) UIImageView *buyImageView;

@property (nonatomic, strong) UILabel *buyLabel;

@end

@implementation BBGGDBuyButton

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
    self.buyImageView = [UIImageView new];
    self.buyLabel = [UILabel new];
    [self addSubview:self.buyImageView];
    [self addSubview:self.buyLabel];
}

- (void)setStatus:(NSInteger)status {
    _status = status;
    [self initUI];
}

- (void)initUI {
    /**
     *  买买买按钮UI
     */
    self.layer.cornerRadius = 4.0f;
    self.layer.borderWidth = 1.0f;
    self.clipsToBounds = YES;
    
    if (self.status == 0) {
        self.backgroundColor = UICOLOR_FONT_IMPORTANT_RED;
        self.layer.borderColor = [UICOLOR_FONT_IMPORTANT_RED CGColor];
        
        self.buyLabel.frame = CGRectMake(5, 12, self.frame.size.width/4*2+5.0f, 20);
        self.buyLabel.text = @"买买买";
        self.buyLabel.font = APP_FONT(14.0f);
        self.buyLabel.textColor = [UIColor whiteColor];
        self.buyLabel.textAlignment = NSTextAlignmentCenter;
        
        self.buyImageView.frame = CGRectMake(self.buyLabel.frame.origin.x+self.buyLabel.frame.size.width+3.0f, 12, 20, 20);
        [self.buyImageView setImage:[UIImage imageNamed:@"buybuybuy"]];
    }else if (self.status == 1) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = [UIColorFromHexadecimalRGB(0xfaa9bf) CGColor];
        
        self.buyLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        self.buyLabel.text = @"即将开始";
        self.buyLabel.font = APP_FONT(14.0f);
        self.buyLabel.textColor = UIColorFromHexadecimalRGB(0xfaa9bf);
        self.buyLabel.textAlignment = NSTextAlignmentCenter;
    }else {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = [UIColorFromHexadecimalRGB(0xfaa9bf) CGColor];
        
        self.buyLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        self.buyLabel.text = @"已结束";
        self.buyLabel.font = APP_FONT(14.0f);
        self.buyLabel.textColor = UIColorFromHexadecimalRGB(0xfaa9bf);
        self.buyLabel.textAlignment = NSTextAlignmentCenter;
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
