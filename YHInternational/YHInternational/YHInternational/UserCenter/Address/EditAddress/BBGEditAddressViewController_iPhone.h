//
//  BBGEditAddressViewController_iPhone.h
//  YHInternational
//
//  Created by BubuGao on 15-4-17.
//  Copyright (c) 2015年 Bubugao. All rights reserved.
//

#import "BBGEditAddressViewController.h"


@interface BBGEditAddressViewController_iPhone : BBGEditAddressViewController

/**
 *  @author holyjoy, 15-09-22 15:09:15
 *
 * 身份证照片是否必须，用来从结算到身份证编辑页面判断
 */
@property(nonatomic,assign) BOOL mustNeedIdCardPhoto;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic,assign)BOOL isEdit;
@end
