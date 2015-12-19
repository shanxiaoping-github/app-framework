//
//  BBGEditIDPhotoTableViewCell.h
//  YHInternational
//
//  Created by Holyjoy on 15/6/8.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^IDfFrontActionBlock)();
typedef void (^IDfBackActionBlock)();
typedef void (^BtnIDFrontActionBlock)();
typedef void (^BtnIDBackActionBlock)();

@interface BBGEditIDPhotoTableViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *titleLabel1;
//身份证照片是否必须
@property (strong, nonatomic) IBOutlet UILabel *MustNeedIdCardPhoto;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *frontButtonHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *frontButtonWidth;

@property (strong, nonatomic) IBOutlet UIImageView *IDFrontImageView;
@property (strong, nonatomic) IBOutlet UIImageView *IDBackImageView;
@property (strong, nonatomic) IBOutlet UIButton *frontButton;
@property (strong, nonatomic) IBOutlet UIButton *backButton;

@property (copy, nonatomic) IDfFrontActionBlock IDFrontblock;
@property (copy, nonatomic) IDfBackActionBlock IDBackblock;
@property (copy, nonatomic) BtnIDFrontActionBlock BtnIDFrontblock;
@property (copy, nonatomic) BtnIDBackActionBlock BtnIDBackblock;

@end
