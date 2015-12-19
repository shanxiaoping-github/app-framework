//
//  BBGShoppingCartBottomView.m
//  YHInternational
//
//  Created by yangjie on 15/5/14.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGShoppingCartBottomView.h"

@implementation BBGShoppingCartBottomView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self createView];
        [self createEditView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
        [self createEditView];

    }
    return self;
}


- (void)createView{
    
    UIImageView *lineView = [UIImageView imageViewWithMyImage:@"深色line" stretchInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self addSubview:lineView];
    
    
    UIButton *editBtn = [UIButton new];
    [editBtn addTarget:self action:@selector(editBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editBtn setTitleColor:UICOLOR_FONT_IMPORTANT_BLACK  forState:UIControlStateNormal];
    [editBtn.titleLabel setFont:APP_FONT_DEMI_LIGHT(16)];
    [editBtn setContentEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 15)];
    [self addSubview:editBtn];
    
//    delete
    _selectCountLabel = [UILabel new];
    [_selectCountLabel setFont:APP_FONT(14)];
    [_selectCountLabel setTextColor:UICOLOR_FONT_IMPORTANT_RED];
    [self addSubview:_selectCountLabel];
    
    _praiceTitleLabel = [UILabel new];
    [_praiceTitleLabel setFont:APP_FONT(14)];
    [_praiceTitleLabel setTextColor:UICOLOR_FONT_GENERAL_GRAYLIGHT];
    [self addSubview:_praiceTitleLabel];
    
    _totalRealPriceLabel = [UILabel new];
    [_totalRealPriceLabel setFont:APP_FONT_DEMI_LIGHT(14)];
    [_totalRealPriceLabel setTextColor:UICOLOR_FONT_IMPORTANT_RED];
    [self addSubview:_totalRealPriceLabel];
    
    UIButton *sumbitBtn = [UIButton buttonWithTitle:@"结算" color:UICOLOR_FONT_IMPORTANT_RED];
    [sumbitBtn addTarget:self action:@selector(sumbitBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [sumbitBtn setTitle:@"结算" forState:UIControlStateNormal];
    sumbitBtn.layer.cornerRadius = 4;
    [sumbitBtn.titleLabel setFont:APP_FONT_DEMI_LIGHT(15)];
    [self addSubview:sumbitBtn];

    
    

    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(0);
        make.left.mas_equalTo(@0);
        make.right.mas_equalTo(self.mas_right);
    }];
    
    [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.centerY.mas_equalTo(self);
    }];
    
    [sumbitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.size.mas_equalTo(CGSizeMake(113, 45));
        make.centerY.mas_equalTo(self);
    }];

    
    [_selectCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.lessThanOrEqualTo(sumbitBtn.mas_left).offset(-3);
        make.top.mas_equalTo(self.mas_top).offset(12);
    }];
    
 
    
    [_totalRealPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_praiceTitleLabel.mas_top).offset(0);
//        make.left.mas_equalTo(_praiceTitleLabel.mas_right);
        make.right.lessThanOrEqualTo(sumbitBtn.mas_left).offset(-3);
        
    }];
    
    [_praiceTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.left.mas_equalTo(_selectCountLabel);
        make.right.equalTo(_totalRealPriceLabel.mas_left).offset(0);
        make.top.mas_equalTo(_selectCountLabel.mas_top).offset(22);
    }];
    
    
}
- (void)createEditView{
    
    _editView = [UIView new];
    _editView.frame = CGRectMake(-self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
    _editView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_editView];

    UIImageView *lineView = [UIImageView imageViewWithMyImage:@"深色line" stretchInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [_editView addSubview:lineView];
    
    UIButton *cancelBtn = [UIButton new];
    [cancelBtn addTarget:self action:@selector(cancelBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    //    [_allSelectBtn setImage:[UIImage imageNamed:@"unSelected"] forState:UIControlStateNormal];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:UICOLOR_FONT_IMPORTANT_BLACK  forState:UIControlStateNormal];
    [cancelBtn.titleLabel setFont:APP_FONT_DEMI_LIGHT(16)];
    [cancelBtn setContentEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 15)];
    [_editView addSubview:cancelBtn];

    
    UIButton *deleteBtn = [UIButton buttonWithMyImage:@"addCart_normal" stretchInset:UIEdgeInsetsMake(8, 8, 8, 8)];
    [deleteBtn addTarget:self action:@selector(deleteSelectedProducts:) forControlEvents:UIControlEventTouchUpInside];
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [deleteBtn setTitleColor:UICOLOR_FONT_IMPORTANT_RED  forState:UIControlStateNormal];
    [deleteBtn.titleLabel setFont:APP_FONT_DEMI_LIGHT(16)];
    [_editView addSubview:deleteBtn];
    
    

    
    UIImage* btnImg = [UIImage imageNamed:@"addCart_normal"];
    UIImage* btnImg2 = [btnImg resizableImageWithCapInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
    CGSize imgSize = btnImg.size;
    UIButton* allSelectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [allSelectBtn setBackgroundImage:btnImg2 forState:UIControlStateNormal];
    [allSelectBtn setFrame:CGRectMake(0, 0, imgSize.width, imgSize.height)];
//    UIButton *allSelectBtn = [UIButton buttonWithMyImage:@"addCart_normal" stretchInset:UIEdgeInsetsMake(8, 8, 8, 8)];
    [allSelectBtn addTarget:self action:@selector(allSelectBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [allSelectBtn setTitle:@"全选" forState:UIControlStateNormal];
    [allSelectBtn setTitleColor:UICOLOR_FONT_IMPORTANT_RED  forState:UIControlStateNormal];
    [allSelectBtn.titleLabel setFont:APP_FONT_DEMI_LIGHT(16)];
    [_editView addSubview:allSelectBtn];
    
    
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_editView.mas_top).offset(0);
        make.left.mas_equalTo(@0);
        make.right.mas_equalTo(_editView.mas_right);
    }];
    
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.centerY.mas_equalTo(_editView);
    }];
    
    [allSelectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_editView.mas_right).offset(-10);
        make.size.mas_equalTo(CGSizeMake(113, 45));
        make.centerY.mas_equalTo(_editView);
    }];
    
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(allSelectBtn.mas_left).offset(-10);
        make.size.mas_equalTo(CGSizeMake(113, 45));
        make.centerY.mas_equalTo(_editView);
    }];
   


}
- (void)reloadViewWithCartGroup:(BBGProductsCart*)model{
    NSString *selectStr = [NSString stringWithFormat:@"已选 %ld 件",(long)model.totalType];
    
    NSMutableAttributedString *selectAttStr = [[NSMutableAttributedString alloc] initWithString:selectStr];
    [selectAttStr addAttribute:NSForegroundColorAttributeName value:UICOLOR_FONT_GENERAL_GRAYLIGHT range:NSMakeRange(0,2)];
    [selectAttStr addAttribute:NSForegroundColorAttributeName value:UICOLOR_FONT_GENERAL_GRAYLIGHT range:NSMakeRange(selectStr.length-1,1)];
    
    NSString *totalRealPriceStr = [NSString stringWithFormat:@"￥%0.2f",model.totalRealPrice/100.0];
//    [_allSelectBtn setTitle:@"编辑" forState:UIControlStateNormal];
    if (model.selected == 1) {
        [_allSelectBtn setSelected:YES];
//        [_allSelectBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
    }else if (model.selected == 2){
        [_allSelectBtn setSelected:NO];
//        [_allSelectBtn setImage:[UIImage imageNamed:@"unSelected"] forState:UIControlStateNormal];
    }else{
         [_allSelectBtn setSelected:NO];
//         [_allSelectBtn setImage:[UIImage imageNamed:@"shoppingIconStop"] forState:UIControlStateNormal];
    }
    [_selectCountLabel setAttributedText:selectAttStr];
    [_praiceTitleLabel setText:@"商品总价:"];
    [_totalRealPriceLabel setText:totalRealPriceStr];
}


- (void)allEditBtnPressed:(UIButton*)btn{
    BBGShoppingCartSelectType type = BBGShoppingCartCancelSelected;
    if (btn.selected) {
        type = BBGShoppingCartCancelSelected;
    }else{
        type = BBGShoppingCartSomeDelete;
    }
    
    if ([self.delegate respondsToSelector:@selector(shoppingCartEditButtonClick:)]) {
        [self.delegate shoppingCartEditButtonClick:type];
    }
}
- (void)deleteSelectedProducts:(UIButton *)btn{
    
    BBGShoppingCartSelectType type = BBGShoppingCartSomeDelete;
    if ([self.delegate respondsToSelector:@selector(shoppingCartEditButtonClick:)]) {
        [self.delegate shoppingCartEditButtonClick:type];
    }

}
- (void)allSelectBtnPressed:(UIButton*)btn{
    
    BBGShoppingCartSelectType type = BBGShoppingCartCancelSelected;
    if (btn.selected) {
        type = BBGShoppingCartCancelSelected;
//        [btn setTitle:@"全选" forState:UIControlStateNormal];
        [btn setTitleColor:UICOLOR_FONT_IMPORTANT_RED  forState:UIControlStateNormal];
        UIImage* btnImg = [UIImage imageNamed:@"addCart_normal"];
        UIImage* btnImg2 = [btnImg resizableImageWithCapInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
        [btn setBackgroundImage:btnImg2 forState:UIControlStateNormal];
    }else{
        type = BBGShoppingCartAllSelected;
        [btn setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
        UIImage* btnImg = [UIImage imageNamed:@"RedBtn_normal"];
        UIImage* btnImg2 = [btnImg resizableImageWithCapInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
        [btn setBackgroundImage:btnImg2 forState:UIControlStateNormal];
    }
    if ([self.delegate respondsToSelector:@selector(shoppingCartSelectButtonClick:)]) {
        [self.delegate shoppingCartSelectButtonClick:type];
    }
    btn.selected = !btn.selected;
}
- (void)cancelBtnPressed:(UIButton*)btn{
    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect rectBack = _editView.frame;
        rectBack.origin.x -= IPHONE_WIDTH;
        [_editView setFrame:rectBack];
        
    }];
    
}
- (void)editBtnPressed:(UIButton*)btn{

    [UIView animateWithDuration:0.25 animations:^{
        CGRect rect1 = _editView.frame;
        rect1.origin.x += IPHONE_WIDTH;
        [_editView setFrame:rect1];
        
    } completion:^(BOOL finished){
        [UIView animateWithDuration:0.125 animations:^{
            CGRect rect2 = _editView.frame;
            rect2.origin.x -= 10;
            [_editView setFrame:rect2];
        } completion:^(BOOL finished){
            [UIView animateWithDuration:0.125 animations:^{
                CGRect rect3 = _editView.frame;
                rect3.origin.x += 10;
                [_editView setFrame:rect3];

            }];
        }];
    }];
}
- (void)sumbitBtnPressed:(UIButton*)btn{
    if ([self.delegate respondsToSelector:@selector(tradeCheckout)]) {
        [self.delegate tradeCheckout];
    }
}

@end
