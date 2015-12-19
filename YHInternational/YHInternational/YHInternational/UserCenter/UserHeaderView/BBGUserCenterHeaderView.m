//
//  BBGUserCenterHeaderView.m
//  YHInternational
//
//  Created by yangjie on 15/5/8.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGUserCenterHeaderView.h"
#import "common.h"

@interface BBGUserCenterHeaderView ()

@property (nonatomic,strong)NSMutableArray *titleArray;

@end


@implementation BBGUserCenterHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self createView];
        [self createMenuView];
    }
    return self;
}

- (void)initData{
    _titleArray = [[NSMutableArray alloc] init];
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    [dict setObject:@"unPay" forKey:@"img"];
    [dict setObject:@"待付款" forKey:@"tittle"];
    [_titleArray addObject:dict];
    dict =[NSMutableDictionary dictionary];
    [dict setObject:@"unDelivery" forKey:@"img"];
    [dict setObject:@"待发货" forKey:@"tittle"];
    [_titleArray addObject:dict];
    dict =[NSMutableDictionary dictionary];
    [dict setObject:@"unReceipt" forKey:@"img"];
    [dict setObject:@"待收货" forKey:@"tittle"];
    [_titleArray addObject:dict];
    dict =[NSMutableDictionary dictionary];
    [dict setObject:@"uc_receipt" forKey:@"img"];
    [dict setObject:@"已收货" forKey:@"tittle"];
    [_titleArray addObject:dict];
    dict =[NSMutableDictionary dictionary];
    [dict setObject:@"finished" forKey:@"img"];
    [dict setObject:@"全部订单" forKey:@"tittle"];
    [_titleArray addObject:dict];
}


- (void)createView{
    _bgImgView = [UIImageView new];
    [_bgImgView setUserInteractionEnabled:YES];
    [_bgImgView setImage:THEME_IMAGE(@"userBckg")];
    [self addSubview:_bgImgView];
    
    UIImage *defaultUserIconImg = [UIImage imageNamed:@"defaultUserIcon"];
    
    _userHeadBgView = [UIView new];
    [_userHeadBgView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:_userHeadBgView];
    
    _userHeadImage = [UIButton new];
    [_userHeadImage sd_setImageWithURL:[NSURL URLWithString:@""] forState:UIControlStateNormal placeholderImage:defaultUserIconImg];
    [_userHeadImage addTarget:self action:@selector(userHeadPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_userHeadImage sizeToFit];
    [_userHeadBgView addSubview:_userHeadImage];
    
    _nameTextField = [BBGLineTextField new];
    [_nameTextField setFont:APP_FONT(16)];
    [_nameTextField setTextAlignment:NSTextAlignmentCenter];
    [_nameTextField setTextColor:[UIColor whiteColor]];
    [self addSubview:_nameTextField];
    
    WS(ws)
    [_bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(ws);
        make.left.mas_equalTo(@(0));
        make.top.mas_equalTo(@(0));
    }];
    
    [_userHeadBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(86, 86));
        make.centerX.equalTo(ws);
        make.top.mas_equalTo(23);
    }];
    
    [_userHeadImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(84, 84));
        make.center.equalTo(ws.userHeadBgView);
    }];
    
    [_nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 25));
        make.centerX.equalTo(ws);
        make.top.equalTo(ws.userHeadBgView.mas_bottom).offset(3);
    }];
}


- (void)createMenuView{
    float viewWith = IPHONE_WIDTH/[_titleArray COUNT];
    UIView *menuBgView = [UIView new];
    //[menuBgView setBackgroundColor:[UIColor redColor]];
    [self addSubview:menuBgView];
    [menuBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(@63);
        make.bottom.mas_equalTo(self);
    }];
    
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuViewPressed:)];
    [tapGest setNumberOfTapsRequired:1];
    [tapGest setNumberOfTouchesRequired:1];
    [menuBgView addGestureRecognizer:tapGest];
    
    
    UIView *lastView;
    for (int i=0; i< [_titleArray COUNT]; i++) {
        NSDictionary *dict = [_titleArray ARRAY_OBJ_AT(i)];
        NSString *titltSTr = [dict DICT_OBJ_FOR_K(@"tittle")];
        NSString *imgStr = [dict DICT_OBJ_FOR_K(@"img")];
        
        UIView *view = [UIView new];
        [view setUserInteractionEnabled:NO];
        [self addSubview:view];
        
        UIImageView *titleImgView = [UIImageView new];
        [titleImgView setImage:[UIImage imageNamed:imgStr]];
        [view addSubview:titleImgView];
        
        UILabel *titleLabel = [UILabel new];
        [titleLabel setTextColor:[UIColor whiteColor]];
        [titleLabel setFont:APP_FONT(12)];
        [titleLabel setText:titltSTr];
        [titleLabel sizeToFit];
        [view addSubview:titleLabel];
        
        BBGBadgeView *badgeView = [[BBGBadgeView alloc] initWithBackgroundImage:[UIImage imageNamed:@"barge"]];
        CGRect rect = badgeView.frame;
        rect.origin.x = 14;
        rect.origin.y = -5;
        [badgeView setFrame:rect];
        [titleImgView addSubview:badgeView];
        
        if (i == 0) {
            _unPayBadgeView = badgeView;
        }else if (i == 1){
            _unSendBadgeView = badgeView;
        }else if (i == 2){
            _unReceiptBadgeView = badgeView;
        }else if (i == 3){
            _receiptBadgeView = badgeView;
        }else if (i == 4){
            _unFinishBadgeView = badgeView;
        }
        
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lastView ? lastView.mas_right :@2);
            make.width.mas_equalTo(viewWith);
            make.height.mas_equalTo(menuBgView);
            make.bottom.equalTo(self.mas_bottom);
        }];
        lastView = view;
        
        [titleImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(view);
            make.top.mas_equalTo(@12);
        }];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleImgView.mas_bottom).offset(8);
            make.centerX.equalTo(view);
        }];
        
//        [badgeView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(titleImgView.mas_top).offset(64);
//            make.right.mas_equalTo(titleImgView.mas_right).offset(-6);
//        }];
        
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _userHeadBgView.layer.cornerRadius = FRAMEW(_userHeadBgView)/2.0;
    _userHeadBgView.layer.masksToBounds = YES;
    
    _userHeadImage.layer.cornerRadius = FRAMEH(_userHeadBgView)/2.0;
    _userHeadImage.layer.masksToBounds = YES;
}


- (void)userHeadPressed:(UIButton*)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(chooseUserIcons)]) {
        [self.delegate chooseUserIcons];
    }
}

-(void)menuViewPressed:(UITapGestureRecognizer*)tapGest{
    CGPoint point =  [tapGest locationInView:self];
    float _w = IPHONE_WIDTH/[_titleArray COUNT];
    int selectIndex = (int)(point.x/_w);
    if (self.delegate && [self.delegate respondsToSelector:@selector(menuItemSelected:atIndex:)]) {
        [self.delegate menuItemSelected:self atIndex:selectIndex];
    }
    
}

@end
