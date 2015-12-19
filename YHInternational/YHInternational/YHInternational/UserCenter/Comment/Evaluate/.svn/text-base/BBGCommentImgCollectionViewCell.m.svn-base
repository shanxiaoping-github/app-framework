//
//  BBGCommentImgCollectionViewCell.m
//  YHInternational
//
//  Created by yangjie on 15/5/19.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGCommentImgCollectionViewCell.h"


@implementation BBGCommentImgCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self != nil) {
        self.imgBtn = [UIButton new];
        [self.imgBtn addTarget:self action:@selector(addPhotoPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.imgBtn];
        
        self.delBtn = [UIButton new];
        [self.delBtn setImage:[UIImage imageNamed:@"deletePhoto"] forState:UIControlStateNormal];
        [self.delBtn addTarget:self action:@selector(delBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.delBtn];
        
        [self.imgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(@5);
            make.left.mas_equalTo(@2.5);
            make.bottom.mas_equalTo(@-5);
            make.right.mas_equalTo(@-2.5);
        }];
        
        [self.delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.imgBtn.mas_top);
            make.right.mas_equalTo(self.imgBtn.mas_right);
        }];
        
    }
    return self;
}

- (void)reloadCell:(BBGImgModel*)model{
    self.uploadImgModel = model;
    if (model.isAddBtn) {
        [self.delBtn setHidden:YES];
        [self.imgBtn setBackgroundColor:[UIColor clearColor]];
        [self.imgBtn setUserInteractionEnabled:YES];
        [self.imgBtn setImage:[UIImage imageNamed:@"addPhoto"] forState:UIControlStateNormal];
    }else{
        [self.delBtn setHidden:NO];
        [self.imgBtn setUserInteractionEnabled:NO];
        [self.imgBtn setBackgroundColor:UICOLOR_BACKGROUND_HILIGHT_GRAY];
        [self.imgBtn sd_setImageWithURL:[NSURL URLWithString:model.url] forState:UIControlStateNormal];
    }
    
}

- (void)addPhotoPressed:(UIButton*)btn{
    if (self.uploadImgModel.isAddBtn) {
        if ([self.delegate respondsToSelector:@selector(commentImgCollectionViewAddPhoto:)]) {
            [self.delegate commentImgCollectionViewAddPhoto:self.uploadImgModel];
        }
    }
}

- (void)delBtnPressed:(UIButton*)btn{
    if ([self.delegate respondsToSelector:@selector(commentImgCollectionViewDelPhoto:)]) {
        [self.delegate commentImgCollectionViewDelPhoto:self.uploadImgModel];
    }
}



+ (CGSize)imageSize{
    CGSize size = CGSizeZero;
    int countOneLine = 5;
    float _w = (IPHONE_WIDTH-16)/(countOneLine*1.0);
    size = CGSizeMake(_w, _w);
    return size;
}

@end
