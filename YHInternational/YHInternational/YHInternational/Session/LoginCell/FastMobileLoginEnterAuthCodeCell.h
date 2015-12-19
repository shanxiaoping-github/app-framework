//
//  FastMobileLoginEnterAuthCodeCell.h
//  YHInternational
//
//  Created by Holyjoy on 15/6/9.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^resendActionBlock)();

@interface FastMobileLoginEnterAuthCodeCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UITextField *authCodeTextfield;
@property (strong, nonatomic) IBOutlet UIButton *resendBtn;
@property (copy,nonatomic) resendActionBlock resendBtnBlock;


@end
