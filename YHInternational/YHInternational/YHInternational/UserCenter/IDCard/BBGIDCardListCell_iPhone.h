//
//  BBGIDCardListCell_iPhone.h
//  YHInternational
//
//  Created by Holyjoy on 15/6/24.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^deleteBtnBlock)();
typedef void (^editBtnBlock)();
typedef void (^BtnIDFrontActionBlock)();
typedef void (^BtnIDBackActionBlock)();

@interface BBGIDCardListCell_iPhone : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *IDCardNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *IDCardNumberLabel;
@property (strong, nonatomic) IBOutlet UIImageView *frontImageView;
@property (strong, nonatomic) IBOutlet UIImageView *reverImageView;
@property (strong, nonatomic) IBOutlet UIButton *deleteBtn;
@property (strong, nonatomic) IBOutlet UIButton *editBtn;
@property (copy,nonatomic) deleteBtnBlock deleteActionBlock;
@property (copy,nonatomic) editBtnBlock editActionBlock;
@property (copy, nonatomic) BtnIDFrontActionBlock BtnIDFrontblock;
@property (copy, nonatomic) BtnIDBackActionBlock BtnIDBackblock;


@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bgFrontImageViewConstarint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *frontImageViewConstarint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *frontBtnConsarint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bgBackImageViewConstarint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *backImageViewConstarint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *backBtnConstraint;

+(CGFloat)cellHeight;

- (void)updateCellData:(BBGIDCard *)userIDCard;


@end
