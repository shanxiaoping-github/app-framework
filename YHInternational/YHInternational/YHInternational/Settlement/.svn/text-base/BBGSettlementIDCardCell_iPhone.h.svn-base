//
//  BBGSettlementIDCardCell_iPhone.h
//  YHInternational
//
//  Created by Timmy OuYang on 15/6/12.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    BBGAddressCellSelecteAreaPicker,     //选择地区
    BBGAddressCellSelecteSubmit,     //提交地址
    BBGAddressCellSelecteIDCardFront,     //身份证正面
    BBGAddressCellSelecteIDCardBack,//身份证反面
}BBGSettlementAddressCellSelecteType;

@protocol SettlementIDCardCellDelegate;
@interface BBGSettlementIDCardCell_iPhone : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *nameLblTf;
@property (weak, nonatomic) IBOutlet UITextField *phoneTf;
@property (weak, nonatomic) IBOutlet UITextField *addressTf;
@property (weak, nonatomic) IBOutlet UITextField *idCardTf;
@property (weak, nonatomic) IBOutlet UIButton *selectAreaButton;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UILabel *submitTipLbl;
@property (weak, nonatomic) IBOutlet UIButton *IDCardFrontButton;
@property (weak, nonatomic) IBOutlet UIButton *IDCardBackButton;
@property (assign, nonatomic) id<SettlementIDCardCellDelegate> delegate;
@property (strong, nonatomic) BBGAddress *address;

/*!
 temp = 0 需身份验证  
 temp = 1 不需要身份验证
 */
+ (float)cellHeightWithTemp:(NSInteger)temp;

@end

@protocol SettlementIDCardCellDelegate <NSObject>

- (void)settlementIDCard:(BBGSettlementIDCardCell_iPhone *)addressCell didSelectedType:(BBGSettlementAddressCellSelecteType)selecteType;

@end