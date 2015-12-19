//
//  BBGSecKillCellTableViewCell.m
//  YHInternational
//
//  Created by 黄 灿 on 15/9/22.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGSecKillTableViewCell.h"
@implementation BBGSecKillTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        WS(weakSelf);
        
        leftInfoView = [[UIView alloc]init];
        [self.contentView addSubview:leftInfoView];
        [leftInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView);
            make.left.equalTo(weakSelf.contentView);
            make.bottom.equalTo(weakSelf.contentView);
            make.width.mas_equalTo(@135);
        }];
        
        
        
        mainImageView = [[UIImageView alloc]init];
        mainImageView.contentMode=UIViewContentModeScaleAspectFit;
        [leftInfoView addSubview:mainImageView];
        [mainImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(leftInfoView);
            make.size.mas_equalTo(CGSizeMake(115, 115));
        }];
        
        rightInfoView = [[UIView alloc]init];
        [self.contentView addSubview:rightInfoView];
        [rightInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.contentView);
            make.top.equalTo(weakSelf.contentView);
            make.bottom.equalTo(weakSelf.contentView);
            make.left.equalTo(leftInfoView.mas_right);
        }];
        
        rightInitView = [[UIView alloc]init];
        [rightInfoView addSubview:rightInitView];
        [rightInitView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(rightInfoView);
            make.width.equalTo(rightInfoView.mas_width);
        }];
        
        
        
        watermarkImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"alreadyOut"]];
        [mainImageView addSubview:watermarkImageView];
        [watermarkImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(mainImageView.mas_centerX);
            make.centerY.equalTo(mainImageView.mas_centerY);
        }];
        
        
        
        
        
        /**
         *  购物车图标
         */
        cartImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ShoppingCartIcon"]];
        [rightInitView addSubview:cartImage];
        cartImage.userInteractionEnabled = YES;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(AddCart:)];
        [cartImage addGestureRecognizer:gesture];
        [cartImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(rightInitView.mas_right).offset(-10);
            make.bottom.equalTo(rightInitView.mas_bottom);
            make.size.mas_equalTo(cartImage.image.size);
        }];
        
        
        titleLabel = [[UILabel alloc]init];
        titleLabel.textColor = UICOLOR_FONT_IMPORTANT_BLACK;
        titleLabel.textAlignment=NSTextAlignmentLeft;
        titleLabel.numberOfLines=3;
        titleLabel.font = APP_FONT(14);
        [rightInitView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(rightInitView.mas_top).offset(40);
            make.left.equalTo(rightInitView.mas_left);
            make.right.equalTo(rightInitView.mas_right).offset(-10);
        }];
        
        
        UIView *topView = [[UIView alloc]init];
        [rightInitView addSubview:topView];
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(rightInitView);
            make.top.equalTo(rightInitView);
            make.right.equalTo(rightInitView);
            make.height.mas_equalTo(@40);
        }];
        
        leftTimeLabel = [[UILabel alloc]init];
        leftTimeLabel.textColor = UICOLOR_FONT_GENERAL_GRAY;
        leftTimeLabel.textAlignment=NSTextAlignmentCenter;
        leftTimeLabel.font = APP_FONT(13);
        [topView addSubview:leftTimeLabel];
        [leftTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(topView);
            make.centerY.equalTo(topView);
        }];
        
        rightTimeLabel = [[UILabel alloc]init];
        rightTimeLabel.textColor = UICOLOR_FONT_GENERAL_GRAY;
        rightTimeLabel.textAlignment=NSTextAlignmentCenter;
        rightTimeLabel.font = APP_FONT(13);
        [topView addSubview:rightTimeLabel];
        [rightTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(topView.mas_right).offset(-10);
            make.centerY.equalTo(topView);
        }];
        
        
        topRightImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"SecKillTime"]];
        [topView addSubview:topRightImage];
        [topRightImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(rightTimeLabel.mas_left).offset(-5);
            make.centerY.equalTo(topView);
            make.size.mas_equalTo(topRightImage.image.size);
        }];
        
        
        
        unCroosedPrice = [[UILabel alloc]init];
        unCroosedPrice.textAlignment=NSTextAlignmentLeft;
        [rightInitView addSubview:unCroosedPrice];
        
        croosedPrice = [[UILabel alloc]init];
        croosedPrice.textAlignment=NSTextAlignmentLeft;
        [rightInitView addSubview:croosedPrice];
        
        
        lineView = [[UIView alloc]init];
        lineView.backgroundColor = UIColorFromHexadecimalRGB(0xe5e5e5);
        [rightInfoView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(rightInfoView.mas_left);
            make.right.equalTo(rightInfoView.mas_right).offset(0);
            make.top.equalTo(rightInfoView.mas_top);
            make.height.mas_equalTo(@0.5);
        }];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
-(void)setIndexpath:(NSIndexPath *)indexpath{
    _indexpath = indexpath;
    if (indexpath.row!=1) {
        lineView.alpha = 1;
    }else{
        lineView.alpha = 0;
    }
}
-(void)updateCell:(BBGSecKillProduct *)seckill isUp:(BOOL)isUp{
    [[BBGCountdownManager sharedInstance]removeObserver:self];

    
    _secProduct = seckill;
    [mainImageView sd_setImageWithURL:[NSURL URLWithString:seckill.imageUrl] placeholderImage:[UIImage imageNamed:@"goodsDefault"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (cacheType ==SDImageCacheTypeNone) {
            [mainImageView setFadeInWithDefaultTime];
        }
        
    }];
    
    
    
    
    
    NSString * payStr;
    NSString * finalStr;
    if (!seckill.crossedPrice) {
        payStr = [NSString stringWithFormat:@"￥%.2f",[seckill.unCrosedPrice integerValue]/100.0];
        finalStr = @"";
    }else{
        payStr = [NSString stringWithFormat:@"￥%.2f",[seckill.unCrosedPrice integerValue]/100.0];
        finalStr = [NSString stringWithFormat:@"￥%.2f",[seckill.crossedPrice integerValue]/100.0];
    }
    
    /**
     解决窄屏幕上显示不全的问题
     */
    float bigger,smaller;
    if (IPHONE_WIDTH==320) {
        bigger = 22.0;
        smaller = 13.0;
    }else{
        bigger = 22.0;
        smaller = 13.0;
    }
    
    
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",payStr]];
    [attrStr addAttribute:NSFontAttributeName value:APP_FONT_DEMI_LIGHT(smaller) range:NSMakeRange(0, 1)];
    [attrStr addAttribute:NSFontAttributeName value:APP_FONT_DEMI_LIGHT(bigger) range:NSMakeRange(1, payStr.length - 3)];
    [attrStr addAttribute:NSFontAttributeName value:APP_FONT_DEMI_LIGHT(smaller) range:NSMakeRange(payStr.length - 3, 3)];
    [attrStr addAttribute:NSForegroundColorAttributeName value:UICOLOR_FONT_IMPORTANT_RED range:NSMakeRange(0, payStr.length)];
    
    
    
    
    
    [unCroosedPrice mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(rightInitView.mas_left);
        make.top.equalTo(titleLabel.mas_bottom).offset(10);
        make.bottom.equalTo(rightInitView);
        make.height.mas_equalTo(bigger);
    }];
    unCroosedPrice.attributedText = attrStr;
    [unCroosedPrice setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    
    //sale价格
    NSMutableAttributedString * attrStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",finalStr]];
    
    [attrStr1 addAttribute:NSFontAttributeName value:APP_FONT(smaller) range:NSMakeRange(0, finalStr.length)];
    
    [attrStr1 addAttribute:NSForegroundColorAttributeName value:UICOLOR_FONT_GENERAL_GRAYLIGHT range:NSMakeRange(0, finalStr.length)];
    
    
    [attrStr1 addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, finalStr.length)];
    [attrStr1 addAttribute:NSStrikethroughColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, finalStr.length)];
    
    
    [croosedPrice mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(unCroosedPrice.mas_bottom);
        make.left.equalTo(unCroosedPrice.mas_right).offset(15).priorityHigh();
        make.right.equalTo(cartImage.mas_left).offset(-10).priorityLow();
        
        make.height.mas_equalTo(smaller);
    }];
    [croosedPrice setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    croosedPrice.attributedText = attrStr1;
    
    
    NSMutableAttributedString * productName = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",seckill.productName]];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentLeft;
    paragraphStyle.maximumLineHeight = 60;  //最大的行高
    paragraphStyle.lineSpacing = 3;  //行自定义行高度
    [productName addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,_secProduct.productName.length)];
    titleLabel.attributedText = productName;
    
    
    if ([_secProduct.productType integerValue]==1) {
        if (seckill.goodsStatus==0) {
            [cartImage setImage:[UIImage imageNamed:@"PayMoney"]];
        }
        else
        {
            [cartImage setImage:[UIImage imageNamed:@"payMoneyOff"]];
        }
        
    }
    else
    {
        if (seckill.goodsStatus ==0) {
            [cartImage setImage:[UIImage imageNamed:@"ShoppingCartIcon"]];
        }
        else
        {
            [cartImage setImage:[UIImage imageNamed:@"ShoppingCartIconOff"]];
            
        }
    }
    
    switch (seckill.goodsStatus) {
        case 1:
        {
            watermarkImageView.image = [UIImage imageNamed:@"alreadyOut"];
            watermarkImageView.alpha = 1;
        }
            break;
        case 2:
        {
            watermarkImageView.image = [UIImage imageNamed:@"alreadySaleOut"];
            watermarkImageView.alpha = 1;
        }
            break;
        case 3:
        {
            watermarkImageView.image = [UIImage imageNamed:@"alreadyUndercarriage"];
            watermarkImageView.alpha = 1;
        }
            break;
        default:
        {
            watermarkImageView.alpha = 0;
        }
            break;
    }
    
    
    
    
    long long begin=[seckill.activityStartTime longLongValue]/1000;
    long long end =[seckill.activityEndTime longLongValue]/1000;
    NSDate *date = [[BBGConfiguration sharedInstance]getCurrentServerTime];
    NSTimeInterval dis = [date timeIntervalSince1970];
    NSString * disStr = [NSString stringWithFormat:@"%i", (int)dis];
    long long a = [disStr longLongValue];
    
    
    
    
    
    
    /*
     *  进行中  当前时间介于开始与结束之间
     */
    if(begin<a&&a<end){
        leftTimeLabel.text = @"剩余时间";
        topRightImage.image = [UIImage imageNamed:@"SecKillTime"];
        leftTimeLabel.textColor = UICOLOR_FONT_GENERAL_GRAY;
        time = end - a;
    }
    
    
    //未开始
    
    if (a<begin) {
        leftTimeLabel.text = @"即将开始";
        topRightImage.image = [UIImage imageNamed:@"SecKillTimeNo"];
        leftTimeLabel.textColor = UIColorFromRGB(250, 169, 191);
        time = begin -a;
    }
    
    //已过期
    if (a>end) {
         [[BBGCountdownManager sharedInstance]removeObserver:self];
        leftTimeLabel.text = @"";
        rightTimeLabel.text= @"00:00:00";
        rightTimeLabel.textColor = UICOLOR_FONT_GENERAL_GRAY;
    }else{
        
        [self setTime];
    }
    
    if (begin!=0&&end!=0) {
        [[BBGCountdownManager sharedInstance]addObserver:self];
    }
    
}
- (void)AddCart:(UITapGestureRecognizer *)sender{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(indexClicked:)]&&_secProduct.goodsStatus==0) {
        [self.delegate indexClicked:_indexpath];
    }
    
    
}


-(void)countdown{
    [self setTime];
    
    time--;

    if (time<=-1) {
        [[BBGCountdownManager sharedInstance]removeObserver:self];
        if (_timerDone) {
            _timerDone();
        }
    }
}

- (void)setTime{
    hour = [NSString stringWithFormat:@"%ld",time / (60 * 60)];
    min = [NSString stringWithFormat:@"%ld",(time % (60 * 60)) / 60];
    second = [NSString stringWithFormat:@"%ld",(time % (60 * 60)) % 60];
    
    if ([hour length]==1) {
        hour = [NSString stringWithFormat:@"0%@",hour];
    }
    if ([min length]==1) {
        min = [NSString stringWithFormat:@"0%@",min];
    }
    if ([second length]==1) {
        second = [NSString stringWithFormat:@"0%@",second];
    }
    
    if ([leftTimeLabel.text isEqualToString:@"即将开始"]) {
        rightTimeLabel.text = [NSString stringWithFormat:@"%@:%@:%@",hour,min,second];
        rightTimeLabel.textColor =UIColorFromRGB(250, 169, 191);
    }else{
        NSString *timeString = [NSString stringWithFormat:@"%@:%@:%@",hour,min,second];
        NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",timeString]];
        [attrStr addAttribute:NSFontAttributeName value:APP_FONT_DEMI_LIGHT(13) range:NSMakeRange(0, [hour length])];
        [attrStr addAttribute:NSFontAttributeName value:APP_FONT_DEMI_LIGHT(13) range:NSMakeRange([hour length], 1)];
        [attrStr addAttribute:NSFontAttributeName value:APP_FONT_DEMI_LIGHT(13) range:NSMakeRange([hour length]+1, 2)];
        [attrStr addAttribute:NSFontAttributeName value:APP_FONT_DEMI_LIGHT(13) range:NSMakeRange([hour length]+3, 1)];
        [attrStr addAttribute:NSFontAttributeName value:APP_FONT_DEMI_LIGHT(13) range:NSMakeRange([hour length]+4, 2)];
        //        [attrStr addAttribute:NSFontAttributeName value:APP_FONT_DEMI_LIGHT(10) range:NSMakeRange([hour length]+6, 1)];
        
        [attrStr addAttribute:NSForegroundColorAttributeName value:UICOLOR_FONT_IMPORTANT_RED range:NSMakeRange(0, [hour length])];
        [attrStr addAttribute:NSForegroundColorAttributeName value:UICOLOR_FONT_IMPORTANT_RED range:NSMakeRange([hour length], 1)];
        [attrStr addAttribute:NSForegroundColorAttributeName value:UICOLOR_FONT_IMPORTANT_RED range:NSMakeRange([hour length]+1,2)];
        [attrStr addAttribute:NSForegroundColorAttributeName value:UICOLOR_FONT_IMPORTANT_RED range:NSMakeRange([hour length]+3, 1)];
        [attrStr addAttribute:NSForegroundColorAttributeName value:UICOLOR_FONT_IMPORTANT_RED range:NSMakeRange([hour length]+4, 2)];
        //        [attrStr addAttribute:NSForegroundColorAttributeName value:UICOLOR_FONT_GENERAL_GRAY range:NSMakeRange([hour length]+6, 1)];
        rightTimeLabel.attributedText = attrStr;
    }
    
}

-(void)dealloc{
    [[BBGCountdownManager sharedInstance]removeObserver:self];
}
@end
