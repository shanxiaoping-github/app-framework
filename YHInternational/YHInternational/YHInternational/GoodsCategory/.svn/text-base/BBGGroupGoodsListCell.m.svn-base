//
//  BBGGroupGoodsListCell.m
//  YHInternational
//
//  Created by 黄 灿 on 15/10/22.
//  Copyright © 2015年 Bubugao. All rights reserved.
//

#import "BBGGroupGoodsListCell.h"
#define TOP_HEIGHT 50
@implementation BBGGroupGoodsListCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _goodsListCell = [[[NSBundle mainBundle] loadNibNamed:@"BBGGoodsListCell_iPhone" owner:nil options:nil] firstObject];
        _goodsListCell.delegate=self;
        
        __weak BBGGroupGoodsListCell *weakSelf = self;
        canChooseView = [[UIView alloc]init];
        [self.contentView addSubview:canChooseView];
        [canChooseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.contentView);
            make.top.equalTo(weakSelf.contentView);
            make.right.equalTo(weakSelf.contentView);
            make.height.mas_equalTo(TOP_HEIGHT);
        }];
        
        btn1 = [UIButton buttonWithName:@"" Price:0.0f];
        btn2 = [UIButton buttonWithName:@"" Price:0.0f];
        btn3 = [UIButton buttonWithName:@"" Price:0.0f];
        btn1.tag =1001;
        btn2.tag =1002;
        btn3.tag =1003;
        [btn1 setBackgroundColor:[UIColor whiteColor]];
        [btn2 setBackgroundColor:[UIColor colorWithRed:240.0f/255 green:241.0f/255 blue:242.0f/255 alpha:1.0f]];
        [btn3 setBackgroundColor:[UIColor colorWithRed:240.0f/255 green:241.0f/255 blue:242.0f/255 alpha:1.0f]];
        [canChooseView addSubview:btn1];
        [canChooseView addSubview:btn2];
        [canChooseView addSubview:btn3];
        [btn1 addTarget:self action:@selector(sectionSelect:) forControlEvents:UIControlEventTouchUpInside];
        [btn2 addTarget:self action:@selector(sectionSelect:) forControlEvents:UIControlEventTouchUpInside];
        [btn3 addTarget:self action:@selector(sectionSelect:) forControlEvents:UIControlEventTouchUpInside];
        self.selectionStyle  = UITableViewCellSelectionStyleNone;
    }
    return self;
}
-(void)updateCellWith:(NSMutableDictionary *)dic{
    productArray = [dic objectForKey:@"array"];
    whichChoosed = [[dic objectForKey:@"choose"] integerValue];
    selfDic = dic;
    __weak BBGGroupGoodsListCell *weakSelf =self;
    [_goodsListCell updateCellWith:productArray[0]];
    if (!view) {
        view = _goodsListCell.contentView;
        [self.contentView addSubview:view];
    }else{
        view = _goodsListCell.contentView;
    }
    
    
    [view mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView);
        make.right.equalTo(weakSelf.contentView);
        make.bottom.equalTo(weakSelf.contentView);
        make.size.mas_equalTo(view.frame.size).priorityHigh(900);
    }];
    
    switch ([productArray count]) {
        case 2:
        {
            [btn1 mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(canChooseView);
                make.left.equalTo(canChooseView);
                make.bottom.equalTo(canChooseView);
                make.width.mas_equalTo(IPHONE_WIDTH/2);
            }];
            [btn2 mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(canChooseView);
                make.right.equalTo(canChooseView);
                make.bottom.equalTo(canChooseView);
                make.width.mas_equalTo(IPHONE_WIDTH/2);
            }];
        }
            break;
       
        default:
        {
            [btn1 mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(canChooseView);
                make.left.equalTo(canChooseView);
                make.bottom.equalTo(canChooseView);
                make.width.mas_equalTo(IPHONE_WIDTH/3);
            }];
            [btn2 mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(canChooseView);
                make.left.equalTo(btn1.mas_right);
                make.bottom.equalTo(canChooseView);
                make.width.mas_equalTo(IPHONE_WIDTH/3);
            }];
            [btn3 mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(canChooseView);
                make.right.equalTo(canChooseView);
                make.bottom.equalTo(canChooseView);
                make.width.mas_equalTo(IPHONE_WIDTH/3);
            }];

        }
            break;
    }
    
    
    for (UILabel *label in btn1.subviews) {
        if (label.tag==20011) {
            [label setText:@"1件"];
        }
        if (label.tag==20012) {
            [label setText:@"100.00"];
        }
    }
    for (UILabel *label in btn2.subviews) {
        if (label.tag==20011) {
            [label setText:@"2件"];
        }
        if (label.tag==20012) {
            [label setText:@"90.00"];
        }
    }
    for (UILabel *label in btn3.subviews) {
        if (label.tag==20011) {
            [label setText:@"3件"];
        }
        if (label.tag==20012) {
            [label setText:@"80.00"];
        }
    }
    
    switch (whichChoosed) {
        case 0:
        {
            [self sectionSelect:btn1];
        }
            break;
        case 1:
        {
            [self sectionSelect:btn2];
        }
            break;
        case 2:
        {
            [self sectionSelect:btn3];
        }
            break;
        default:
            break;
    }
}
+(float)cellHeight{
    return [BBGGoodsListCell_iPhone cellHeight]+TOP_HEIGHT;
}
- (void)sectionSelect:(UIButton *)sender{
    if (btn1!=sender) {
        btn1.backgroundColor = [UIColor colorWithRed:240.0f/255 green:241.0f/255 blue:242.0f/255 alpha:1.0f];
    }
    if (btn2!=sender) {
        btn2.backgroundColor = [UIColor colorWithRed:240.0f/255 green:241.0f/255 blue:242.0f/255 alpha:1.0f];
    }
    
    if (btn3!=sender) {
        btn3.backgroundColor = [UIColor colorWithRed:240.0f/255 green:241.0f/255 blue:242.0f/255 alpha:1.0f];
    }
    
    sender.backgroundColor = [UIColor whiteColor];

    switch (sender.tag) {
        case 1001:
        {
            [_goodsListCell updateCellWith:[productArray ARRAY_OBJ_AT(0)]];
            [selfDic setObject:@"0" forKey:@"choose"];
        }
            break;
        case 1002:
        {
            [_goodsListCell updateCellWith:[productArray ARRAY_OBJ_AT(1)]];
            [selfDic setObject:@"1" forKey:@"choose"];
        }
            break;
        case 1003:
        {
            [_goodsListCell updateCellWith:[productArray ARRAY_OBJ_AT(2)]];
            [selfDic setObject:@"2" forKey:@"choose"];
        }
            break;
        default:
            break;
    }
}
-(void)goodsListCell:(BBGGoodsListCell_iPhone *)listCell itemDidSelectedWith:(CellItemIndex)itemIndex{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(goodsListCell:itemDidSelectedWith:)]) {
        [self.delegate goodsListCell:self itemDidSelectedWith:itemIndex];
    }
}
@end
