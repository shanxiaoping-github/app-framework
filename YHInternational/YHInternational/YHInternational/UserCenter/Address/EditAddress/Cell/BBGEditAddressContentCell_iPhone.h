//
//  BBGEditAddressContentCell_iPhone.h
//  YHInternational
//
//  Created by BubuGao on 15-4-22.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    EDITADDRESSINFO = 0, // 详细信息
    EDITUSERNAME,        // 收货人
    EDITPHONE,           // 联系电话
    EDITIDCARDNAME,      // 身份证界面真实姓名
    EDITIDCARD           // 身份证号码
}BBGEditAddressType;

@protocol BBGEditAddressContentCellDelegate <NSObject>

-(void)editAddressWithType:(BBGEditAddressType)typ value:(NSString *)value;
@end
@interface BBGEditAddressContentCell_iPhone : UITableViewCell<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UILabel *titleName;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UIImageView *separateLine;
@property (assign, nonatomic) BBGEditAddressType type;
@property (weak, nonatomic) id<BBGEditAddressContentCellDelegate> delegate;
@end
