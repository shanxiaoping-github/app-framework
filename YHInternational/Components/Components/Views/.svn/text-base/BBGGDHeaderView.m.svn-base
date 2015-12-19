//
//  BBGGDHeaderView.m
//  Components
//
//  Created by 彭腾 on 15/10/12.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGGDHeaderView.h"
#import "Common.h"

@interface BBGGDHeaderView ()

@property (nonatomic, strong) UIButton *praise;

@property (nonatomic, strong) UIButton *comment;

@property (nonatomic, strong) CALayer *leftLayer;

@end

@implementation BBGGDHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(!self){
        return nil;
    }
    [self initObject];
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(!self){
        return nil;
    }
    [self initObject];
    
    return self;
}

- (void)setIsPraise:(BOOL)isPraise {
    _isPraise = isPraise;
    [self initUI];
}

- (void)initObject {
    self.praise = [UIButton buttonWithType:UIButtonTypeCustom];
    self.comment = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftLayer = [CALayer layer];
    [self addSubview:self.praise];
    [self addSubview:self.comment];
    [self.layer addSublayer:self.leftLayer];
}

- (void)layoutSubviews {
    self.praise.frame = CGRectMake(self.frame.size.width-39.0f, 4.0f, 24.0f, 24.0f);
    self.comment.frame = CGRectMake(self.praise.frame.origin.x-51.0f, 4.0f, 24.0f, 24.0f);
    self.leftLayer.frame = CGRectMake(0, 0, 0.5f, self.frame.size.height);
    self.leftLayer.backgroundColor = RGB_CELL_GRAY.CGColor;
    [self initUI];
}

- (void)initUI {
    if (_isPraise == NO) {
        [self.praise setBackgroundImage:[UIImage imageNamed:@"gd_praise_normal"] forState:UIControlStateNormal];
    }else {
        [self.praise setBackgroundImage:[UIImage imageNamed:@"gd_praise_selected"] forState:UIControlStateNormal];
    }
    [self.comment setBackgroundImage:[UIImage imageNamed:@"gd_comment"] forState:UIControlStateNormal];
    [self.praise addTarget:self action:@selector(praiseClick) forControlEvents:UIControlEventTouchUpInside];
    [self.comment addTarget:self action:@selector(commentClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)praiseClick {
    if (self.praiseButton) {
        self.praiseButton();
    }
}

- (void)commentClick {
    if (self.commentButton) {
        self.commentButton();
    }
}

- (void)commentButtonAction:(CommentBlock)block {
    self.commentButton = block;
}

- (void)praiseButtonAction:(PraiseBlock)block {
    self.praiseButton = block;
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
