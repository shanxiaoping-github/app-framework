//
//  BBGGoodsListFilterView.m
//  BuBuGao
//
//  Created by calvin on 14-8-21.
//  Copyright (c) 2014年 BuBuGao. All rights reserved.
//

#import "BBGGoodsListFilterView_iPhone.h"
#import "BBGComponents.h"
#import "UIImage+Stretch.h"

@interface BBGGoodsListFilterView_iPhone ()

@property (weak, nonatomic) IBOutlet UIButton *defaultButton;
@property (weak, nonatomic) IBOutlet UIButton *priceButton;
@property (weak, nonatomic) IBOutlet UIButton *saleButton;
@property (weak, nonatomic) IBOutlet UIButton *gradeArrowButton;
@property (weak, nonatomic) IBOutlet UIButton *priceArrowButton;
@property (weak, nonatomic) IBOutlet UIButton *salesArrowButton;
@property (strong, nonatomic) IBOutlet UIImageView *selectedButtomView;

@property (nonatomic, strong) NSDictionary *attributes;
@property (nonatomic, assign) SortType type;

@end

@implementation BBGGoodsListFilterView_iPhone

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _type = SortTypeDefault;
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        bgImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:bgImageView];
        [self sendSubviewToBack:bgImageView];
        bgImageView.image = [[UIImage imageNamed:@"categoryBackground"] stretchImage];
    }
    return self;
}

- (void)awakeFromNib {
    _type = SortTypeDefault;
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    bgImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:bgImageView];
    [self sendSubviewToBack:bgImageView];
    bgImageView.image = [[UIImage imageNamed:@"goodsListFilterBg"] stretchImage];
    
    self.defaultButton.selected = YES;
    self.salesArrowButton.hidden = YES;
    
    self.selectedButtomView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"选中底线"] stretchImage]];
    [self.selectedButtomView setFrame:CGRectMake(35, 40, 56, 2)];
    [self addSubview:_selectedButtomView];

    //初始化各个按钮选中与非选中状态
    [self.defaultButton setTitleColor:UIColorFromHexadecimalRGB(0xf34568) forState:UIControlStateSelected];
    [self.defaultButton setTitleColor:UIColorFromHexadecimalRGB(0x333333) forState:UIControlStateNormal];
    
    [self.priceButton setTitleColor:UIColorFromHexadecimalRGB(0xf34568) forState:UIControlStateSelected];
    [self.priceButton setTitleColor:UIColorFromHexadecimalRGB(0x333333) forState:UIControlStateNormal];

    [self.saleButton setTitleColor:UIColorFromHexadecimalRGB(0xf34568) forState:UIControlStateSelected];
    [self.saleButton setTitleColor:UIColorFromHexadecimalRGB(0x333333) forState:UIControlStateNormal];
    
    [self.priceArrowButton setImage:[UIImage imageNamed:@"价格倒序"] forState:UIControlStateSelected];
    [self.priceArrowButton setImage:[UIImage imageNamed:@"价格icon"] forState:UIControlStateNormal];

}

- (void)reloadView {
    if (self.defaultButton.selected == YES) {
        return;
    }
    self.defaultButton.selected = YES;
    self.priceButton.selected = NO;
    self.priceArrowButton.selected = NO;
    self.saleButton.selected = NO;
    self.salesArrowButton.hidden = YES;
    _type = SortTypeDefault;
    
    [UIView animateWithDuration:0.25 animations:^{
        [_selectedButtomView setCenter:CGPointMake(self.defaultButton.superview.center.x+5, _selectedButtomView.center.y)];
    }];
}


//默认排序
- (IBAction)actionOfDefault:(UIButton *)sender {
    if (sender.selected == YES) {
        return;
    }
    sender.selected = YES;
    self.priceButton.selected = NO;
    self.priceArrowButton.selected = NO;
    self.saleButton.selected = NO;
    self.salesArrowButton.hidden = YES;
    _type = SortTypeDefault;
    
    [UIView animateWithDuration:0.25 animations:^{
        [_selectedButtomView setCenter:CGPointMake(sender.superview.center.x+5, _selectedButtomView.center.y)];
    }];
    [self notifyFilter];
}

//价格排序
- (IBAction)actionOfPrice:(UIButton *)sender {
    if (_priceArrowButton.selected) {
        [UIView animateWithDuration:0.25 animations:^{
            _priceArrowButton.transform = CGAffineTransformIsIdentity(_priceArrowButton.transform) ? CGAffineTransformMakeRotation(M_PI) : CGAffineTransformIdentity;
            [_selectedButtomView setCenter:CGPointMake(sender.superview.center.x-5, _selectedButtomView.center.y)];
        }completion:^(BOOL finished) {
            _type = CGAffineTransformIsIdentity(_priceArrowButton.transform) ? SortTypePriceAscend : SortTypePriceDescend;
            [self notifyFilter];
        }];
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            [_selectedButtomView setCenter:CGPointMake(sender.superview.center.x-5, _selectedButtomView.center.y)];
        }];
        _priceButton.selected = YES;
        _priceArrowButton.selected = YES;
        _saleButton.selected = NO;
        _salesArrowButton.hidden = YES;
        _defaultButton.selected = NO;
        _type = CGAffineTransformIsIdentity(_priceArrowButton.transform) ? SortTypePriceAscend : SortTypePriceDescend;
        [self notifyFilter];
    }
}

//销量降序
- (IBAction)actionOfSales:(UIButton *)sender {
    
    if (sender.selected == YES) {
        return;
    }
    _salesArrowButton.selected = YES;
    _saleButton.selected = YES;
    _salesArrowButton.hidden = NO;
    _priceButton.selected = NO;
    _priceArrowButton.selected = NO;
    _defaultButton.selected = NO;
    _type = SortTypeSalesDescend;
    
    [UIView animateWithDuration:0.25 animations:^{
        [_selectedButtomView setCenter:CGPointMake(_saleButton.superview.center.x-5, _selectedButtomView.center.y)];
    }];

    [self notifyFilter];
}

- (void)clearSearchItems {
    _type = SortTypeDefault;
    
    self.defaultButton.selected = YES;
    self.priceButton.selected = NO;
    self.priceArrowButton.selected = NO;
    self.saleButton.selected = NO;
    self.salesArrowButton.hidden = YES;
    self.attributes = nil;
    
    [self notifyFilter];
}

- (void)notifyFilter {
    if (self.delegate && [self.delegate respondsToSelector:@selector(goodsListFilterView:selectedSortType:)]) {
        [self.delegate goodsListFilterView:self selectedSortType:self.type];
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
